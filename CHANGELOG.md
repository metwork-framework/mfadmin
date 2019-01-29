<a name="unreleased"></a>
## [Unreleased]

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

