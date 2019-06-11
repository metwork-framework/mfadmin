.. index:: dashboards, metrics
# Create specific dashboards

You may create your own :index:`Grafana dashboards`. You may refer to the official [Grafana](https://grafana.com/docs/) documentation and the :ref:`mfdata_additional_tutorials:Implement custom monitoring and metrics in a plugin` tutorial.  

.. todo:: add some doc and links to create custom Kibana dashboards.

Then, it is recommended to [save/export your custom dashboard(s)](#saving-your-own-dashboards).

# Useful links and Tips

## Telegraf error (HTTP 403)

.. tip::
	If you do not see any metrics in your Grafana dashboard, check the `telegraf.log` file in the `log` directory of the root MFDATA directory.

    If you see `[agent] Error writing to output [influxdb]: could not write any address` and/or `net/http: request canceled (Client.Timeout exceeded while awaiting headers)`, you are probably behind a proxy, and this could happen when MFADMIN and MFDATA are not runinng on the same machine.

    You should try to fix this issue by setting the `HTTP_PROXY`, `HTTPS_PROXY` and/or `NO_PROXY` in the `/etc/default/telegraf` file or the `/etc/profile.d/proxy.sh`, `/etc/profile`, e.g. `NO_PROXY="*"`


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

- List the retention policies

    ```sql
    Connected to http://localhost:18086 version 1.7.2
    InfluxDB shell version: 1.7.2
    Enter an InfluxQL query
    > show retention policies
    ```
- List the series (the collection of data):

    ```sql
    Connected to http://localhost:18086 version 1.7.2
    InfluxDB shell version: 1.7.2
    Enter an InfluxQL query
    > show series
    ```
    
- List measurements (metrics):

    ```sql
    Connected to http://localhost:18086 version 1.7.2
    InfluxDB shell version: 1.7.2
    Enter an InfluxQL query
    # Query the cpu metrics
    > show measurements
    ```

- Querying measurements (metrics):

    ```sql
    Connected to http://localhost:18086 version 1.7.2
    InfluxDB shell version: 1.7.2
    Enter an InfluxQL query
    # Query the cpu metrics
    > select * from cpu
    ```
    
    ```sql
    Connected to http://localhost:18086 version 1.7.2
    InfluxDB shell version: 1.7.2
    Enter an InfluxQL query
    # Query the postgresql metrics
    > select * from postgresql
    ```
    
    ```sql
    Connected to http://localhost:18086 version 1.7.2
    InfluxDB shell version: 1.7.2
    Enter an InfluxQL query
    # Query the grib_to_netcdf_metrics metrics
    > select * from grib_to_netcdf_metrics
    ```
    
    ```sql
    Connected to http://localhost:18086 version 1.7.2
    InfluxDB shell version: 1.7.2
    Enter an InfluxQL query
    # Query the filecount metrics
    > select * from filecount
    ```
    
.. seealso::
    `Influx Query Language (InfluxQL) reference <https://docs.influxdata.com/influxdb/v1.7/query_language/>`_


## Saving your own dashboards

.. important::
	| When you upgrade MFADMIN Metwork package, the :index:`Grafana` and :index:`Kibana` dashboards are overwritten, so that you may lose the custom dashboards you designed.
    | So, it's highly recommended to **export** the dashboards you want to keep, and the **import** the dashboards once the Metwork upgrade is done.
    
    | In order to export (import) **Grafana dashboards**, check `Grafana documentation <http://docs.grafana.org/reference/export_import/>`_.
    | In order to export (import) **Kibana dashboards**, check `Kibana documentation <https://www.elastic.co/guide/en/kibana/current/api.html>`_ ou use the `/opt/metwork-mfadmin/bin/export_kibana_dashboard.py` script.

.. todo:: explain how to automatically load the 'custom' dashbords (store them in /etc/metwork.config.d/mfadmin/grafana_dashboards and  /etc/metwork.config.d/mfadmin/kibana_dashboards/

.. todo:: about export_kibana_dashboard.py and import_kibana_dashboard.py

## Saving the InfluxDB database

.. important::
	When you upgrade MFADMIN Metwork package, the InfluxDB database that contains metrics is overwritten.

    So, it's recommended to **backup** the InfluxDB database, and the **restore** it once the Metwork upgrade is done.

    In order to backup/restore InfluxDB database, check **Administration 'Backing up and restoring'** menu from the `InfluxDB documentation <https://docs.influxdata.com/influxdb/>`_.


## Metrics retention


.. todo:: influxdb data retention - period period on which to flush & clear the aggregator - explain "fullres", "medres" and "lowres" resolution.
.. todo:: about elasticsearch.clean and MFADMIN crontab


## Grafana  retention


.. todo:: influxdb data retention
.. todo:: about elasticsearch.clean and MFADMIN crontab

## json_log files

.. todo:: explain json_file
<!--
Intentional comment to prevent m2r from generating bad rst statements when the file ends with a block .. xxx ::
-->