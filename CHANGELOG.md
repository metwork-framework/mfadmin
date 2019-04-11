<a name="unreleased"></a>
## [Unreleased]

### Feat
- add ES datasources in grafana provisionning
- add ES template for mflog
- add debug message in case of mfadmin.init silent crash
- add kibana dashboards import/export/provisionning
- influxdb and grafana update
- introduce mflog indices rotation
- monitor influxdb db size
- remove "CPU usage single core" from system dashboard overview
- secure kibana behind a password protected nginx location

<a name="v0.6.0"></a>
## [v0.6.0] - 2019-04-03
### Feat
- introduce logs management with ES and kibana

### Fix
- fix grafana-cli location for admin password change
- mfserv module metrics about cpu/mem

<a name="v0.5.7"></a>
## [v0.5.7] - 2019-03-16

<a name="v0.5.6"></a>
## [v0.5.6] - 2019-02-16

<a name="v0.5.5"></a>
## [v0.5.5] - 2019-02-09

<a name="v0.5.4"></a>
## [v0.5.4] - 2019-02-06

<a name="v0.5.3"></a>
## [v0.5.3] - 2019-01-31

<a name="v0.5.2"></a>
## [v0.5.2] - 2019-01-31

<a name="v0.5.1"></a>
## [v0.5.1] - 2019-01-29

<a name="v0.5.0"></a>
## [v0.5.0] - 2019-01-29
### Feat
- Changes in management of layer dependencies and metapackage names (only minimal and full) Associated with changes in mfext _metwork.spec, this reduces the number of layers installed by default when installing mfadmin (only necessary mfext layers are installed) Metapackage metwork-mfadmin-minimal only installs the necessary layers for mfadmin to work properly Metapackage metwork-mfadmin or metwork-mfserv-full installs all mfadmin layers
- add influxdb system monitoring
- better mfdata dashboard
- better mfserv dashboard
- better system dashboard
- execute integration tests directly from mfadmin module and launch them on a pull request on the module
- influxdb upgrade (=>1.7.2)

<a name="v0.4.1"></a>
## [v0.4.1] - 2019-01-09

<a name="v0.4.0"></a>
## [v0.4.0] - 2019-01-08
### Feat
- add a first version of telegraf dashboard
- add influxdb local monitoring
- add options to be able to run grafana behind a reverse proxy
- better system dashboard (add diskio stats)
- the grafana admin password is now a configuration option

### Fix
- fix mfadmin.init with a changed grafana admin password

