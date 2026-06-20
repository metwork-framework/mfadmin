# CHANGELOG

## [Unreleased]

### New Features

- upgrade elasticsearch and kibana from 6.8.23 to 8.18.2 (#344)
- upgrade grafana from 8.5.22 to 11.6.3 (#345)
- upgrade influxdb from 1.7.9 to 1.11.7 (#347)
- upgrade grafana-loki from 2.2.1 to 3.5.1 (#348)
- bump starlette from 0.40.0 to 0.47.3 (moderate CVE-2025-54121) (#352)
- bump python-ldap from 3.4.4 to 3.4.5 (#380)
- add check_delay in circus arbiter config setting (#381)
- upgrade starlette from 0.47.3 to 0.49.1 (fix high CVE-2025-62727) (#384)
- bump filelock from 3.18.0 to 3.20.1 (fix moderate CVE-2025-68146) (#391)
- bump filelock from 3.20.1 to 3.20.3 (fix CVE-2026-22701) (#394)
- bump python-multipart to 0.0.22 (fix high CVE-2026-24486) (#396)
- bump PyJWT from 2.4.0 to 2.12.1 (fix high CVE-2026-32597) (#401)
- bump pyasn1 from 0.6.2 to 0.6.3 (fix high CVE-2026-30922) (#403)
- bump python-multipart to 0.0.26 (moderate CVE-2026-40347) (#406)
- bump python-multipart to 0.0.29 (fix high CVE-2026-42561) (#412)
- bump idna from 3.11 to 3.16 (fix moderate CVE-2026-45409) (#414)
- bump starlette to 1.2.1 (CVE-2026-48710) and update all packages (#416)
- add pydantic-settings for BaseSettings moved from pydantic
- bump PyJWT from 2.12.1 to 2.13.0 (fix high CVE-2026-48526) (#420)
- bump starlette from 1.2.1 to 1.3.1 (fix high CVE-2026-54283) (#426)
- python-multipart from 0.0.29 to 0.0.30 (fix high CVE-2026-53539) (#433)

### Bug Fixes

- disable xpack.screenshotting to avoid permission denied error (#365)
- remove modules xpack-ml and repository-s3 from elasticsearch (#369)
- update versions grafana dashboard (#378)
- fix non annotated attributes (compatbility pydantic 2)
- adaptation to starlette 1 breaking change (#424)


