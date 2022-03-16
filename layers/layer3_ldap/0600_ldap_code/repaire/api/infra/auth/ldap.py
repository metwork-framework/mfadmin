from typing import Any, Dict, Optional, Tuple

import ldap

from repaire.api.app.auth import AuthenticationBackendInterface
from repaire.api.app.settings import get_settings
from repaire.api.entities.user import AuthenticatedUser


class AuthenticationLDAPBackend(AuthenticationBackendInterface):
    def _search(self, conn, what: str) -> Optional[Tuple[str, Dict[str, Any]]]:
        result = conn.search_s(get_settings().ldap_base, ldap.SCOPE_SUBTREE, what)
        try:
            return (result[0][0], result[0][1])
        except IndexError:
            return None

    def check(
        self, username_or_email: str, password: str
    ) -> Optional[AuthenticatedUser]:
        conn = ldap.initialize(get_settings().ldap_url)
        conn.set_option(ldap.OPT_REFERRALS, 0)
        conn.set_option(ldap.OPT_PROTOCOL_VERSION, 3)
        conn.set_option(ldap.OPT_NETWORK_TIMEOUT, get_settings().ldap_timeout)
        conn.set_option(ldap.OPT_TIMEOUT, get_settings().ldap_timeout)
        if get_settings().ldap_starttls == 1:
            conn.set_option(ldap.OPT_X_TLS_CACERTFILE, get_settings().ldap_cacert_file)
            conn.set_option(ldap.OPT_X_TLS, ldap.OPT_X_TLS_DEMAND)
            conn.set_option(ldap.OPT_X_TLS_DEMAND, True)
            conn.set_option(ldap.OPT_X_TLS_REQUIRE_CERT, ldap.OPT_X_TLS_ALLOW)
            conn.set_option(ldap.OPT_X_TLS_NEWCTX, 0)
            conn.start_tls_s()
        if get_settings().ldap_bind_who != "":
            tmp = conn.simple_bind_s(
                get_settings().ldap_bind_who, get_settings().ldap_bind_pass
            )
            if tmp[0] != ldap.RES_BIND:
                raise Exception("bad bind code from LDAP server: %i", tmp[0])
        res: Optional[Tuple[str, Dict[str, Any]]] = self._search(
            conn, "(mail=%s)" % username_or_email
        )
        if res is None:
            res = self._search(conn, "(uid=%s)" % username_or_email)
            if res is None:
                return None
        try:
            tmp = conn.simple_bind_s(res[0], password)
        except Exception:
            return None
        uid_number: int = 0
        try:
            uid_number = int(res[1].get("uidNumber")[0])  # type: ignore
        except Exception:
            raise
        display_name: str = username_or_email
        if res[1].get("displayName") is not None:
            display_name = res[1].get("displayName")[0].decode("utf8")  # type: ignore
        uid: str = username_or_email
        if res[1].get("uid") is not None:
            uid = res[1].get("uid")[0].decode("utf8")  # type: ignore
        mail: str = username_or_email
        if res[1].get("mail") is not None:
            mail = res[1].get("mail")[0].decode("utf8")  # type: ignore
        return AuthenticatedUser(
            username=uid,
            email=mail,
            display_name=display_name,
            uid_number=uid_number,
        )
