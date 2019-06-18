.. index:: dashboards, metrics
# Create specific dashboards

You can create your own :index:`Grafana dashboards` and :index:`Kibana dashboards`. 

When created, it is recommended to [save/export your custom dashboard(s)](#saving-your-own-dashboards).

.. seealso::
    :doc:`mfadmin_monitoring_plugins`


## Create specific Grafana dashboards

Check the official [Grafana](https://grafana.com/docs/) documentation and the :ref:`mfdata_additional_tutorials:Implement custom monitoring and metrics in a plugin` tutorial.  

## Create specific Kibana dashboards

Check the official [Kibana](https://www.elastic.co/guide/en/kibana/current/dashboard-getting-started.html) documentation and the [Kibana - Building your own dashboards tutorial](https://www.elastic.co/guide/en/kibana/current/tutorial-build-dashboard.html)


# Useful links and Tips

## Telegraf error (HTTP 403)

.. tip::
	If you do not see any metrics in your Grafana dashboard, check the `telegraf.log` file in the `log` directory of the root MFDATA directory.

    If you see `[agent] Error writing to output [influxdb]: could not write any address` and/or `net/http: request canceled (Client.Timeout exceeded while awaiting headers)`, you are probably behind a proxy, and this could happen when MFADMIN and MFDATA are not runinng on the same machine.

    You should try to fix this issue by setting the `HTTP_PROXY`, `HTTPS_PROXY` and/or `NO_PROXY` in the `/etc/default/telegraf` file or the `/etc/profile.d/proxy.sh`, `/etc/profile`, e.g. `NO_PROXY="*"`

.. index:: Influxdb database
## Querying the InfluxDB database

.. tip::
	You may query the InfluxDB database from the InfluxDB’s command line interface `influx` located in `/opt/metwork-mfadmin-master/opt/monitoring/bin/influx`.

    Check **Tools 'InfluxDB command line interface (CLI/shell)'** menu from the `InfluxDB documentation <https://docs.influxdata.com/influxdb/>`_.

    The MFADMIN database name is `metrics`. The default port is `18086`.

**Examples:**

- Connect to the influx database

    ```bash
    # Connect to the influx database
    /opt/metwork-mfadmin-master/opt/metrics/bin/influx -database 'metrics' -host 'localhost' -port '18086'
    ```

    ```console
    Connected to http://localhost:18086 version 1.7.2
    InfluxDB shell version: 1.7.2
    Enter an InfluxQL query
    >
    ```

- List the databases

    ```sql
    > show databases
    ```
    

- List the retention policies

    ```sql
    > show retention policies
    ```
    
- List the series (the collection of data):

    ```sql
    > show series
    ```
    
- List measurements (metrics):

    ```sql
    # Query the cpu metrics
    > show measurements
    ```

- Querying measurements (metrics):

    ```sql
    # Query the cpu metrics
    > select * from cpu
    ```
    
    ```sql
    # Query the postgresql metrics
    > select * from postgresql
    ```
    
    ```sql
    # Query the grib_to_netcdf_metrics metrics
    > select * from grib_to_netcdf_metrics
    ```
    
    ```sql
    # Query the filecount metrics
    > select * from filecount
    ```
    
.. seealso::
    `Influx Query Language (InfluxQL) reference <https://docs.influxdata.com/influxdb/v1.7/query_language/>`_


## Saving your own dashboards

.. important::
	| When you upgrade MFADMIN Metwork package, the :index:`Grafana dashboards` and :index:`Kibana dashboards`  are overwritten, so that you may lose the custom dashboards you designed.
    | So, it's highly recommended to **export** the dashboards you want to keep, and the **import** the dashboards once the Metwork upgrade is done.
    
    | In order to export (import) **Grafana dashboards**, check `Grafana documentation <http://docs.grafana.org/reference/export_import/>`_.
    | In order to export (import) **Kibana dashboards**, check `Kibana documentation <https://www.elastic.co/guide/en/kibana/current/api.html>`_ or use the `/opt/metwork-mfadmin/bin/export_kibana_dashboard.py` script for exporting and the `/opt/metwork-mfadmin/bin/import_kibana_dashboard.py` script for importing.


If you build [custom dashboards](#create-specific-dashboards), you would like to be able to reload them automatically when MFADMIN service is started. 

In order to do this, you have to store them:
- in the `/etc/metwork.config.d/mfadmin/grafana_dashboards` for Grafana dashboards
- in the `/etc/metwork.config.d/mfadmin/kibana_dashboards` for Kibana dashboards

## Saving the InfluxDB database

.. important::
	When you upgrade MFADMIN Metwork package, the InfluxDB database that contains metrics is overwritten.

    So, it's recommended to **backup** the InfluxDB database, and the **restore** it once the Metwork upgrade is done.

    In order to backup/restore InfluxDB database, check **Administration 'Backing up and restoring'** menu from the `InfluxDB documentation <https://docs.influxdata.com/influxdb/>`_.
    
    The name of the MFADMIN Influxdb database is `metrics`

.. index:: data retention, data resolution, metrics retention, metrics resolution
## Metrics retention (resolution)

.. index:: Time-series dashboards, fullres resolution, medres resolution, lowres resolution, statistics aggregator
### InfluxDB retention policies and statistics aggregator

In InfluxDB databases, data are kept for a limited time according :index:`retention policies`, i.e., among other things, **how long InfluxDb keeps the data (duration)**.

In MFADMIN, Telegraf is configured for emitting new aggregate metrics, such as min, max, mean, sum (basic :index:`statistics aggregator` plugin). This aggregator is configured with a **period**.
The period is the size of the window of metrics that each aggregate represents. In other words, the emitted aggregate metric will be the aggregated value of the past period seconds. 

MFADMIN supplies the following retention policies:
- **fullres** : data are kept for **24 hours**, statistics aggregation period is **10 seconds**
- **medres** : data are kept for **7 days**, statistics aggregation period is **60 seconds**
- **lowres** : data are kept for **52 weeks**, statistics aggregation period is **1 hour**

In the :ref:`Grafana dashboards <mfadmin_monitoring_plugins:Grafana Time-series dashboards>`, you can display time-series metrics with the suitable resolution.

.. index:: elasticsearch.clean, ElasticSearch retention period
### Elasticsearch retention

ElasticSearch no longer supports retention period. So, the is no default data retention period. 

To avoid having an ElasticSearch database growing indefinitely, a MFADMIN `elasticsearch.clean` python script is running at regular intervals in order to delete ElasticSearch indices based on age.

The age (lifetime) is configured in the `indices_lifetime` parameter `[elasticsearch]` section of the :ref:`MFADMIN configuration file <mfadmin_intro:MFADMIN configuration>` file, the default value is 5 days, e.g.:

```cfg
[elasticsearch]

...

# indices starting with "filebeat-" are destroyed after {indices_lifetime} days
# -1 => no cleaning
# indices_lifetime = 5
```

.. seealso::
    Check `tmp/config_auto/crontab` file in the root directory of the `mfadmin` user.
    
.. index:: json_file, json_minimal_level, exporting log
## Exporting logs

**This section applies to all MetWork modules.**

Logs are exported in a separate `json` file. This could be useful if you need :index:`monitoring with external tool`.

In order to save logs in a separate file, you have to check/set the `json_file` and `json_minimal_level`  parameters in the `[log]` section of the `config/config.ini` file stored in the root directory of the MetWork module user.

For further details, refer to :ref:`MetWork plugins configuration <mfadmin_monitoring_plugins:Configuration>`.

.. index:: circus hooks, before_start hook, after_start hook
## Circus hooks

Circus provides [hooks](https://circus.readthedocs.io/en/latest/for-devs/writing-hooks/#hooks) used to trigger actions upon watcher events. These hooks are configured in the [circus.ini configuration](https://circus.readthedocs.io/en/latest/for-ops/configuration/) file. 

MFADMIN circus configuration, like the other MetWork modules (MFBASE, MFDATA, MFSERV, ...), implements circus hooks for circus watchers (e.g. `before_start`, `after_start` hooks).

Check the `circus.ini` configuration file in the `tmp/config_auto/` in the root directory of the `mfadmin` user (or other MetWork modules, e.g. `mfbase`, `mfdata`, `mfserv`).

```cfg
...
[watcher:influxdb]
...
hooks.before_start=circus_hooks.before_start_shell
hooks.after_start=circus_hooks.after_start_shell
...

```

In the above example, a shell script is executed before influxdb (:py:func:`hooks.before_start=circus_hooks.before_start_shell <mfcom:circus_hooks.before_start_shell>`) starts and after influxdb is started (:py:func:`hooks.before_start=circus_hooks.before_start_shell <mfcom:circus_hooks.after_start_shell>`).

The shell script name is {hook_name}_{whatcher_name}, e.g:
- before_start_influxdb
- after_start_influxdb 

You will find the hooks script in the `bin` directory of the installed MetWork module, e.g. `/opt/metwork-mfadmin-master/bin/`

<!--
Intentional comment to prevent m2r from generating bad rst statements when the file ends with a block .. xxx ::
-->