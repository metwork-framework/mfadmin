# CHANGELOG


## [Unreleased]

### New Features
- add a new dashboard for versions managing
- influxdb/grafana updates and grafana configured to use
- remove absolute log paths from log_proxy usages (LOGPROXY_LOG_DIRECTORY env variable is used by default)
- log refactoring
- improve log templates for better indexing speed
- adaptation to removal of layer misc@mfext
- better mfdata dashboard


### Bug Fixes
- fix welcome portal usage behind a reverse proxy
- fix welcome portal links if they are behind a reverse proxy
- access to grafana when logs layer is not installed
- tmp fix for #111 (upstream grafana/firefox issue)





