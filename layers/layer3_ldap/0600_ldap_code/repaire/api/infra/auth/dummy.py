from typing import Optional

from repaire.api.app.auth import AuthenticationBackendInterface
from repaire.api.entities.user import AuthenticatedUser


class AuthenticationDummyBackend(AuthenticationBackendInterface):
    def check(
        self, username_or_email: str, password: str
    ) -> Optional[AuthenticatedUser]:
        if username_or_email == password:
            return AuthenticatedUser(
                username=username_or_email,
                email=username_or_email,
                display_name=username_or_email,
            )
        return None
