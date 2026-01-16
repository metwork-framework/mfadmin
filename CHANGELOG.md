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

### Bug Fixes

- disable xpack.screenshotting to avoid permission denied error (#365)
- remove modules xpack-ml and repository-s3 from elasticsearch (#369)
- update versions grafana dashboard (#378)


