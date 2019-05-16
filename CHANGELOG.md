# CHANGELOG


## [Unreleased]

### New Features
- introduce mflog indices rotation
- influxdb and grafana update
- remove "CPU usage single core" from system dashboard overview
- monitor influxdb db size
- add debug message in case of mfadmin.init silent crash
- secure kibana behind a password protected nginx location
- add ES template for mflog
- add ES datasources in grafana provisionning
- add kibana dashboards import/export/provisionning
- kibana dashboard update
- drop es indices after changing es mapping
- Add a dashboard for mfbase


### Bug Fixes
- set kibana default index
- fix building issues with proxy





## v0.6.0 (2019-04-03)

### New Features
- introduce logs management with ES and kibana


### Bug Fixes
- mfserv module metrics about cpu/mem
- fix grafana-cli location for admin password change





