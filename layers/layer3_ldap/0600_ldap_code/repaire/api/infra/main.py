import asyncio
import base64
import ipaddress
import json
import os
import urllib.parse
from functools import cache
from typing import Any, Dict, List, Optional, Tuple
from urllib.parse import urlparse

<<<<<<< HEAD
import aioredis
=======
from redis import asyncio as aioredis

>>>>>>> 65abde0 (feat: upgrade fastapi, starlette, Jinja2 and python-multipart (for security reasons) (#281))
import jwt
import mflog
from fastapi import FastAPI, Form, HTTPException, Request
from fastapi.param_functions import Depends
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from ratelimit import RateLimitMiddleware, Rule
from ratelimit.auths.ip import client_ip
from ratelimit.backends.redis import RedisBackend
from starlette.concurrency import run_in_threadpool
from starlette.responses import JSONResponse

from repaire.api.app.auth import AuthenticationController
from repaire.api.app.settings import get_settings
from repaire.api.app.token import decode_jwt, make_jwt
from repaire.api.entities.user import AuthenticatedUser
from repaire.api.infra.auth import make_auth_backend


DIR = os.path.dirname(__file__)
SLASH_B64URL = "Lw=="

app = FastAPI()
app.mount("/static", StaticFiles(directory=os.path.join(DIR, "static")), name="static")
if get_settings().ratelimit_redis_host is not None:

    async def auth_function(scope: Any) -> Tuple[str, str]:
        try:
            return client_ip(scope)
        except Exception:
            return "default", "default"

    app.add_middleware(
        RateLimitMiddleware,
        authenticate=auth_function,
        backend=RedisBackend(
            host=get_settings().ratelimit_redis_host,
            port=get_settings().ratelimit_redis_port,
        ),
        config={
            r"^/login/check": [Rule(minute=20)],
        },
    )
templates = Jinja2Templates(directory=os.path.join(DIR, "templates"))
mflog.set_config()


@cache
def get_auth_controller() -> AuthenticationController:
    auth_backend = make_auth_backend()
    return AuthenticationController(auth_backend)


def check_redirect_url(url: str):
    parsed_url = urlparse(url)
    if parsed_url.netloc != "":
        if not parsed_url.netloc.endswith("." + get_settings().domain):
            raise HTTPException(
                400,
                "the redirection url: %s is not in the %s domain"
                % (url, get_settings().domain),
            )


@app.get("/login", response_class=HTMLResponse)
async def login(request: Request, b64url: str = "", previous_result: str = ""):
    if b64url == "":
        b64url = SLASH_B64URL
    else:
        decode_b64url_or_raise(b64url)
    context = {"request": request, "b64url": b64url, "previous_result": previous_result}
    return templates.TemplateResponse("login.html", context)


@app.get("/404", response_class=HTMLResponse)
async def notfound(request: Request):
    context = {"request": request}
    return templates.TemplateResponse("404.html", context)


@app.get("/", response_class=HTMLResponse)
async def index(request: Request):
    token: Optional[str] = request.cookies.get(get_settings().cookie_name)
    user: Optional[AuthenticatedUser] = None
    if token is not None and len(token) > 0:
        try:
            user = decode_jwt(token)
        except jwt.ExpiredSignatureError:
            raise HTTPException(400, "expired token")
        except jwt.exceptions.InvalidSignatureError:
            raise HTTPException(400, "invalid token signature")
        except Exception:
            raise HTTPException(400, "can't decode token")
        if user is None:
            raise Exception("user is None (impossible)")
    context = {"request": request, "user": user, "token": token}
    return templates.TemplateResponse("index.html", context)


@app.get("/logout")
async def logout(request: Request, b64url: str = ""):
    if b64url == "":
        b64url = SLASH_B64URL
    url = decode_b64url_or_raise(b64url)
    headers: Dict[str, str] = {
        "Set-Cookie": "%s=; Path=/; Max-Age=0" % get_settings().cookie_name
    }
    check_redirect_url(url)
    return RedirectResponse(url, status_code=302, headers=headers)


def multidict_to_list_of_tuples(mdict) -> List[Tuple[str, str]]:
    res: List[Tuple[str, str]] = []
    for key in mdict.keys():
        for value in mdict.getlist(key):
            res.append((key, value))
    return res


def decode_b64url_or_raise(b64url: str) -> str:
    try:
        missing_padding = len(b64url) % 4
        if missing_padding:
            b64url = b64url + "=" * (4 - missing_padding)
        return base64.urlsafe_b64decode(b64url).decode("utf8")
    except Exception:
        raise HTTPException(status_code=400, detail="invalid b64url: %s" % b64url)


def login_url(b64url: str, previous_result: str) -> str:
    return "/login?b64url=%s&previous_result=%s" % (
        b64url,
        urllib.parse.quote_plus(previous_result),
    )


@app.post("/login/check")
async def login_check(
    username: str = Form(...), password: str = Form(...), b64url: str = Form(...)
):
    await asyncio.sleep(1)  # pour éviter la brute force on force une attente d'1s ici
    # a noter qu'en prod, un middleware est injecté pour faire du rate limiting
    # sur ce endpoint
    return await run_in_threadpool(sync_lock_check, username, password, b64url)


def sync_lock_check(username: str, password: str, b64url: str):
    headers: Dict[str, str] = {}
    user: Optional[AuthenticatedUser] = None
    if username == "jwt":
        try:
            user = decode_jwt(password)
        except Exception:
            url = login_url(b64url, "Token non reconnu")
    else:
        try:
            user = get_auth_controller().check(username, password)
        except Exception:
            mflog.warning("exception during auth_controller.check()", exc_info=True)
            url = login_url(
                b64url, "Problème lors de la vérification de l'identification"
            )
    if user is None:
        url = login_url(b64url, "Identification non reconnue")
    else:
        url = decode_b64url_or_raise(b64url)
        jwt: str = ""
        if username == "jwt":
            jwt = password
        else:
            jwt = make_jwt(user)
        headers = {
            "Set-Cookie": "%s=%s; Path=/; Max-Age=%i"
            % (
                get_settings().cookie_name,
                jwt,
                get_settings().jwt_max_age,
            )
        }
    check_redirect_url(url)
    return RedirectResponse(url, status_code=302, headers=headers)


async def get_redis() -> aioredis.Redis:
    return aioredis.from_url(get_settings().redis_url)
