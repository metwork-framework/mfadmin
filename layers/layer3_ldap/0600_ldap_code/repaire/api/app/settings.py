from functools import cache
from typing import Optional

from pydantic import BaseSettings


class Settings(BaseSettings):
    # domain = "cloudmf.dev"
    domain: str = "localhost"
    cookie_name: str = "cloudmf_token"
    auth_backend: str = "ldap"
    jwt_secret: str = "secret"
    jwt_max_age: int = 3600 * 12
    ldap_url: str = "ldap://ldaps.meteo.fr:636"
    ldap_cacert_file: str = "/etc/pki/tls/certs/ca-bundle.crt"
    ldap_starttls: int = 1
    ldap_timeout: int = 10
    ldap_bind_who = "cn=ovhdev,ou=DPDSI,ou=generiques,dc=meteo,dc=fr"
    ldap_bind_pass = "XXXXXX"
    ldap_base = "ou=people,dc=meteo,dc=fr"
    redis_url = "redis://127.0.0.1"
    redis_key_expiry_seconds = 24 * 60 * 60  # 24 hours in seconds
    force_same_ip: bool = False
    ratelimit_redis_host: Optional[str] = None  # None => no rate limiting
    ratelimit_redis_port: int = 6379

    class Config:
        env_prefix = "repaire_"


@cache
def get_settings() -> Settings:
    return Settings()
