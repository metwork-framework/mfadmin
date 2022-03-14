from pydantic import BaseModel


class AuthenticatedUser(BaseModel):

    username: str
    email: str
    display_name: str
    uid_number: int = 0
