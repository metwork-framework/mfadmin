# release_2.1 CHANGELOG

## [Unreleased]

### New Features

- fix link to rpms repository in installation guide (#271)

## v2.1.4 (2023-06-16)

- No interesting change

## v2.1.3 (2023-04-05)

### Bug Fixes

- move kibana.passwd from ~/tmp to ~/var to prevent removal by crontab (backport #249) (#250)
- metwork version 1.1 hardcoded in _force_grafana_admin_password (… (backport #253) (#256)
- kibana LDAP authent and HTTP Basic authentication (#245) (backport #258) (#259)

## v2.1.2 (2023-02-23)

### New Features

- upgrade starlette to 0.25.0 (security) and fastapi to 0.92.0 (backport #243) (#247)

## v2.1.1 (2023-01-03)

- No interesting change

## v2.1.0 (2022-12-08)

### New Features

- bump PyJWT from 2.3.0 to 2.4.0 for security reasons (#222)

### Bug Fixes

- create file kibana.passwd used by HTTP Basic Authentication for kibana access (#226)


