# Cheatsheet



## `root` service commands

As `root` unix user:

| Command | Description |
| --- | --- |
| `service metwork start` | start all installed metwork services |
| `service metwork stop` | stop all installed metwork services |
| `service metwork status` | check all installed metwork services |
| `service metwork start mfadmin` | start mfadmin metwork services |
| `service metwork stop mfadmin` | stop mfadmin metwork services |
| `service metwork status mfadmin` | check mfadmin metwork services |

> Note: if you don't have `service` command on your Linux distribution, you can use `/etc/rc.d/init.d/metwork` instead of `service metwork`. For example: `/etc/rc.d/init.d/metwork start` instead of `service metwork start`. If your Linux distribution uses `systemd`component, you can also start metwork services with classic `systemctl` commands.



## root files or directories

| Path | Description |
| --- | --- |
| `/etc/metwork.config.d/mfadmin/config.ini` | override the `mfadmin` module configuration at system level (note: the first line of this file must be `[INCLUDE_config.ini]`) |
| `/opt/metwork-mfadmin/config/config.ini` | default `mfadmin` module configuration (useful to see all configuration options) (**do not edit this file** => use the overriding previous file) |


## "load environment" commands

As a "not metwork" unix user (useless if you are logged as a "mfxxx" unix user as the "metwork environment" is already loaded):

| Command | Description |
| --- | --- |
| `source /opt/metwork-mfadmin/share/interactive_profile` | load the mfadmin metwork interactive environment |
| `source /opt/metwork-mfadmin/share/profile` | load the mfadmin metwork environment (same as above but without fancy stuff about banner, colors and prompt) |
| `/opt/metwork-mfadmin/bin/mfadmin_wrapper {YOUR_COMMAND}`| execute the given command in the mfadmin metwork environment without changing anything to the current environment |

> Note: if you don't have `/opt/metwork-mfadmin` symbolic link, use `/opt/metwork-mfadmin-{BRANCH}` instead.

## module commands


As `mfadmin` user:


| Command | Description |
| --- | --- |
| `mfadmin.start` | start mfadmin services |
| `mfadmin.stop` | stop mfadmin services |
| `mfadmin.status` | check mfadmin services |
| `layers` | list installed layers (loaded layers are prefixed by `(*)`), `layers --help` for more details |
| `layer_load {LAYER_NAME}` | load the given layer (which must be installed), example: `layer_load python2_devtools@mfext` |
| `layer_unload {LAYER_NAME}` | unload the given layer (which must be loaded), example: `layer_unload python2@mfext` |
| `components` | list installed software components (loaded components are prefixed by `(*)`), `components --help` for more details |
| `metwork_debug` | debug the current environment (layers, paths, versions...), useful for debugging or bug reporting |
| `outside {YOUR_COMMAND}`| execute the given command outside the metwork environment without changing anything to the current environment |


