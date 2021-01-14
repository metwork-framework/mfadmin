# release_0.8 CHANGELOG

## v0.8.1 (2019-10-19)

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
- use envtpl new option --reduce-multi-blank-lines
- add some smtp options for grafana
- better mfserv dashboard
- send mfadmin mflog logs to itself
- serve kibana and grafana behind the same reverse proxy with a
- serve kibana and grafana behind the same reverse proxy with a
- replace MODULE* environment variables names by MFMODULE* (MODULE_HOME becomes MFMODULE_HOME and so on)
- build mfadmin without mfcom (mfcom layers are now included in mfext)
- add warning if both metrics and logs layers are not loaded
- better mfdata dashboard
- adaptation to removal of layer misc@mfext
- improve log templates for better indexing speed
- log refactoring
- remove absolute log paths from log_proxy usages (LOGPROXY_LOG_DIRECTORY env variable is used by default)
- influxdb/grafana updates and grafana configured to use
- add a new dashboard for versions managing

### Bug Fixes

- fix mfadmin.init with a changed grafana admin password
- mfserv module metrics about cpu/mem
- fix grafana-cli location for admin password change
- set kibana default index
- fix building issues with proxy
- tmp fix for #111 (upstream grafana/firefox issue)
- access to grafana when logs layer is not installed
- fix welcome portal links if they are behind a reverse proxy
- fix welcome portal usage behind a reverse proxy
- clean grafana socket

## v0.8.0 (2019-08-14)

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
- use envtpl new option --reduce-multi-blank-lines
- add some smtp options for grafana
- better mfserv dashboard
- send mfadmin mflog logs to itself
- serve kibana and grafana behind the same reverse proxy with a
- serve kibana and grafana behind the same reverse proxy with a
- replace MODULE* environment variables names by MFMODULE* (MODULE_HOME becomes MFMODULE_HOME and so on)
- build mfadmin without mfcom (mfcom layers are now included in mfext)
- add warning if both metrics and logs layers are not loaded
- better mfdata dashboard
- adaptation to removal of layer misc@mfext
- improve log templates for better indexing speed
- log refactoring
- remove absolute log paths from log_proxy usages (LOGPROXY_LOG_DIRECTORY env variable is used by default)
- influxdb/grafana updates and grafana configured to use
- add a new dashboard for versions managing

### Bug Fixes

- fix mfadmin.init with a changed grafana admin password
- mfserv module metrics about cpu/mem
- fix grafana-cli location for admin password change
- set kibana default index
- fix building issues with proxy
- tmp fix for #111 (upstream grafana/firefox issue)
- access to grafana when logs layer is not installed
- fix welcome portal links if they are behind a reverse proxy
- fix welcome portal usage behind a reverse proxy
- clean grafana socket


