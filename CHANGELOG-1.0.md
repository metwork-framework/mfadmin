# release_1.0 CHANGELOG

## v1.0.4 (2021-08-17)

### Bug Fixes

- fix grafana password reset (backport #196) (#206)

## v1.0.3 (2021-05-18)

### Bug Fixes

- add missing layer dependency (backport #195) (#197)

## v1.0.2 (2021-02-11)

### Bug Fixes

- fix some start/stop issues (bp #185) (#186)

## v1.0.1 (2021-01-26)

- No interesting change

## v1.0.0 (2020-09-19)

### New Features

- better mfdata dashboard
- adaptation to removal of layer misc@mfext
- improve log templates for better indexing speed
- log refactoring
- remove absolute log paths from log_proxy usages (LOGPROXY_LOG_DIRECTORY env variable is used by default)
- influxdb/grafana updates and grafana configured to use
- add a new dashboard for versions managing

### Bug Fixes

- tmp fix for #111 (upstream grafana/firefox issue)
- access to grafana when logs layer is not installed
- fix welcome portal links if they are behind a reverse proxy
- fix welcome portal usage behind a reverse proxy
- clean grafana socket


