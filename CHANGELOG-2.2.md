# release_2.2 CHANGELOG

## v2.2.0 (2023-11-28)

### New Features

- upgrade starlette to 0.25.0 (security) and fastapi to 0.92.0 (#243)
- upgrade grafana to 8.5.22 and kibana & elasticsearch to 6.8.23 (#261)
- upgrade jquery from 3.3.1 to 3.5.1 (security update) (#262)
- bump starlette to 0.27.0 (security reason) and fastapi to 0.95.2 (#265)
- bump certifi to 2023.7.22 (security update) (#268)

### Bug Fixes

- comment in config.ini for elasticsearch indices lifetime (#238)
- move kibana.passwd from ~/tmp to ~/var to prevent removal by crontab (#249)
- metwork version 1.1 hardcoded in _force_grafana_admin_password (… (#253)
- kibana LDAP authent and HTTP Basic authentication (#245) (#258)

