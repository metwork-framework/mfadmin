from abc import ABC, abstractmethod
from typing import Optional

from repaire.api.entities.user import AuthenticatedUser


class AuthenticationBackendInterface(ABC):
    @abstractmethod
    def check(
        self, username_or_email: str, password: str
    ) -> Optional[AuthenticatedUser]:
        raise NotImplementedError()  # pragma: no cover


class AuthenticationController:
    def __init__(self, backend: AuthenticationBackendInterface):
        self.backend: AuthenticationBackendInterface = backend

    def check(
        self, username_or_email: str, password: str
    ) -> Optional[AuthenticatedUser]:
        return self.backend.check(username_or_email, password)
