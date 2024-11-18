from datetime import datetime, timezone
from typing import Any, Dict, List

import jwt

from repaire.api.app.settings import get_settings
from repaire.api.entities.user import AuthenticatedUser


ALGORITHM = "HS256"


def make_jwt(
    user: AuthenticatedUser,
    delta: int = -1,
    limit_to_vhosts: List[str] = [],
    limit_to_ips: List[str] = [],
) -> str:
    if delta == -1:
        delta = get_settings().jwt_max_age
    payload: Dict[str, Any] = {
        "username": user.username,
        "uid_number": user.uid_number,
        "email": user.email,
        "display_name": user.display_name,
        "iat": datetime.now(timezone.utc).replace(tzinfo=None),
        "exp": datetime.now(timezone.utc).replace(tzinfo=None) + \
                datetime.timedelta(seconds=delta),
    }
    if len(limit_to_vhosts) > 0:
        payload["limit_to_vhosts"] = limit_to_vhosts
    if len(limit_to_ips) > 0:
        payload["limit_to_ips"] = limit_to_ips
    return jwt.encode(payload, get_settings().jwt_secret, algorithm=ALGORITHM)


def decode_jwt(token: str) -> AuthenticatedUser:
    payload: Dict[str, Any] = jwt.decode(
        token, get_settings().jwt_secret, algorithms=[ALGORITHM]
    )
    uid_number: int = 0
    try:
        uid_number = int(payload.get("uid_number"))  # type: ignore
    except Exception:
        pass
    return AuthenticatedUser(
        username=payload.get("username"),
        uid_number=uid_number,
        email=payload.get("email"),
        display_name=payload.get("display_name"),
    )
