# release_0.7 CHANGELOG

## v0.7.2 (2019-06-26)

### New Features

- the grafana admin password is now a configuration option
- add options to be able to run grafana behind a reverse proxy
- better system dashboard (add diskio stats)
- add influxdb local monitoring
- add a first version of telegraf dashboard
- add influxdb system monitoring
- influxdb upgrade (=>1.7.2)
- better mfserv dashboard
- better mfdata dashboard
- better system dashboard
- Changes in management of layer dependencies and metapackage names
- execute integration tests directly from mfadmin module
- introduce logs management with ES and kibana
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
- dashboards update
- add some smtp options for grafana
- better mfserv dashboard
- send mfadmin mflog logs to itself

### Bug Fixes

- fix mfadmin.init with a changed grafana admin password
- mfserv module metrics about cpu/mem
- fix grafana-cli location for admin password change
- set kibana default index
- fix building issues with proxy

## v0.7.1 (2019-06-12)

### New Features

- the grafana admin password is now a configuration option
- add options to be able to run grafana behind a reverse proxy
- better system dashboard (add diskio stats)
- add influxdb local monitoring
- add a first version of telegraf dashboard
- add influxdb system monitoring
- influxdb upgrade (=>1.7.2)
- better mfserv dashboard
- better mfdata dashboard
- better system dashboard
- Changes in management of layer dependencies and metapackage names
- execute integration tests directly from mfadmin module
- introduce logs management with ES and kibana
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
- dashboards update
- add some smtp options for grafana
- better mfserv dashboard
- send mfadmin mflog logs to itself

### Bug Fixes

- fix mfadmin.init with a changed grafana admin password
- mfserv module metrics about cpu/mem
- fix grafana-cli location for admin password change
- set kibana default index
- fix building issues with proxy

## v0.7.0 (2019-05-28)

### New Features

- the grafana admin password is now a configuration option
- add options to be able to run grafana behind a reverse proxy
- better system dashboard (add diskio stats)
- add influxdb local monitoring
- add a first version of telegraf dashboard
- add influxdb system monitoring
- influxdb upgrade (=>1.7.2)
- better mfserv dashboard
- better mfdata dashboard
- better system dashboard
- Changes in management of layer dependencies and metapackage names
- execute integration tests directly from mfadmin module
- introduce logs management with ES and kibana
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
- dashboards update
- add some smtp options for grafana
- better mfserv dashboard
- send mfadmin mflog logs to itself

### Bug Fixes

- fix mfadmin.init with a changed grafana admin password
- mfserv module metrics about cpu/mem
- fix grafana-cli location for admin password change
- set kibana default index
- fix building issues with proxy


