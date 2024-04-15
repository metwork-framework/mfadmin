# release_2.0 CHANGELOG

## v2.0.5 (2023-08-31)

- No interesting change

## v2.0.4 (2023-06-16)

- No interesting change

## v2.0.3 (2023-04-04)

### Bug Fixes

- move kibana.passwd from ~/tmp to ~/var to prevent removal by crontab (backport #249) (#251)
- metwork version 1.1 hardcoded in _force_grafana_admin_password (… (backport #253) (#255)

## v2.0.2 (2022-09-16)

### Bug Fixes

- create file kibana.passwd used by HTTP Basic Authentication for kibana access (backport #226) (#228)

## v2.0.1 (2022-06-01)

### New Features

- bump PyJWT from 2.3.0 to 2.4.0 for security reasons (backport #222) (#223)

## v2.0.0 (2022-04-12)

### New Features

- build on centos8 (#216)
- add ldap support for mfadmin (#217)

### Bug Fixes

- security fix to block log4j security hole in elasticsearch (#212)


