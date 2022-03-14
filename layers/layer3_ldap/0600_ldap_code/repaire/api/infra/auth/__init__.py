from repaire.api.app.settings import get_settings
from repaire.api.infra.auth.dummy import AuthenticationDummyBackend
from repaire.api.infra.auth.ldap import AuthenticationLDAPBackend


def make_auth_backend(*args, **kwargs):
    auth_backend = get_settings().auth_backend
    if auth_backend == "ldap":
        return AuthenticationLDAPBackend(*args, **kwargs)
    elif auth_backend == "dummy":
        return AuthenticationDummyBackend(*args, **kwargs)
    raise Exception("unknown auth backend: %s" % auth_backend)
