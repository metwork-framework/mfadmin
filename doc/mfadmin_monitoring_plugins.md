.. index:: monitoring, metrics, Time-series metrics, dashboards
# Monitoring MetWork plugins

This section shows how to configure MetWork modules so that you can monitor your plugin and display dashboards through the :ref:`tools offered in MFADMIN <mfadmin_intro:How it works?>`:

.. seealso::
    | :ref:`mfadmin_miscellaneous:Create specific dashboards`
    | :doc:`layer_metrics`
    | :doc:`layer_logs`

## Configuration

In order to :index:`monitor MetWork plugins`, you have first to:

- install Metwork MFADMIN and MFSYSMON modules
- configure the `[admin]` section and, optionally the `[log]` section of the `config/config.ini` in the root directory of the MetWork module (i.e. MFDATA, MFSERV, MFBASE,...), 

.. important::
    | **When you change a Metwork module configuration, you have to restart the corresponding Metwork module service (MFDATA, MFSERV, MFBASE, ...)**, e.g:
    
    ```bash
    service metwork restart mfdata
    ```

### Enable monitoring

To tell you want to monitor your plugins, first, set the `hostname` parameter value with the host name or IP address where MFADMIN is running:

```cfg
[admin]
# null => no monitoring
# hostname=null
# By setting hostname = localhost, we assume MFADMIN is running on the same Linux machine, 
# if MFADMIN is running on a different machine, set hostname = {your_host_name} or {your_host_ip_address}
hostname=localhost
# influxdb_http_port=18086
...
```
.. important::
    If the above `hostname` parameter is not set or set to `null`, **no monitoring** will be available and **no data** will be displayed in the :ref:`Grafana dashboards <mfadmin_monitoring_plugins:Grafana Time-series dashboards>` and :ref:`Kibana dashboards <mfadmin_monitoring_plugins:Kibana dashboards>`.
     
**By setting** `hostname`, **this will enable monitoring and the time-series metrics (by default)**. The metrics will be stored in the :index:`InfluxDB` databases of the :ref:`MFADMIN host <mfadmin_intro:How it works?>`. The corresponding dashboards will be available through :index:`Grafana` on the :ref:`MFADMIN host <mfadmin_intro:How it works?>`.

### Enable monitoring based on standard logs and mflog logs 

.. index:: send_mflog_logs parameter, json_file, json_minimal_level, standard logs, mflog logs 
Now, if you want to monitor your plugins through [mflog](https://github.com/metwork-framework/mflog) logs, in addition you have to set in the `[log]` section of the `config/config.ini`, the following parameters:
- the `send_mflog_logs` parameter to `1`
- the `json_file` parameter to `AUTO`
- the `json_minimal_level` parameter to the desired level

```cfg
[log]
...
# If send_mflog_logs=1, send mflog logs to the configured admin hostname
send_mflog_logs=1

# duplicate some log messages in JSON to a specific file (for external monitoring tool)
# If json_file value is:
# null => the feature is desactivated
# AUTO => the json_file is @@@MODULE_RUNTIME_HOME@@@/log/json_logs.log if
#         [admin]/hostname != null else null (desactivated)
json_file=AUTO

# Minimal level for this json log file
# (DEBUG => everything,
#  INFO => everything but not DEBUG,
#  WARNING => everything but not DEBUG and INFO,
#  ERROR => everything but not DEBUG, INFO and WARNING,
#  CRITICAL => everything but not DEBUG, INFO, WARNING AND ERROR)
json_minimal_level=DEBUG
...

```

**This will enable the standard logs and mflog logs** to be stored in the :index:`ElasticSearch` database of the :ref:`MFADMIN host <mfadmin_intro:How it works?>`. The corresponding dashboards will be available through :index:`Kibana` on the :ref:`MFADMIN host <mfadmin_intro:How it works?>`.

In the above example, `DEBUG` logs will be duplicated (JSON format) in the `log/json_logs.log` file (in the root directory of the MetWork module user, e.g.`mfadmin`).

Notice the `json_minimal_level` parameter has nothing to do with the `minimal_level` parameter. This allows you monitoring plugins by filtering logs with a different level.

.. important::
    If :ref:`monitoring is not enabled <mfadmin_monitoring_plugins:Enable monitoring>` , the above configuration will have no effect.


.. tip::
    With `mflog <https://github.com/metwork-framework/mflog>`, you may add some attributes to the logger (refer to `mflog example <https://github.com/metwork-framework/mflog#what-is-it->`). These attributes will be logged and may be displayed in the :ref:`Kibana dashboards <mfadmin_monitoring_plugins:Kibana dashboards>`.

.. index:: send_nginx_logs parameter, nginx access logs 
### Enable monitoring based on nginx access logs 

.. note::
    **This section applies only on MetWork modules which embed nginx**

If you want to monitor the **nginx access logs**, you have to configure the `send_nginx_logs` parameter in the the `[log]` section of the `config/config.ini` :

```cfg
[log]
...
# If send_nginx_logs=1, send nginx access logs to the configured admin hostname
send_nginx_logs=1
...
```

**This will enable the nginx access logs** to be stored in the :index:`ElasticSearch` database of the :ref:`MFADMIN host <mfadmin_intro:How it works?>`. The corresponding dashboards will be available through :index:`Kibana` on the :ref:`MFADMIN host <mfadmin_intro:How it works?>`.

.. important::
    If :ref:`monitoring is not enabled <mfadmin_monitoring_plugins:Enable monitoring>` , the above configuration will have no effect.


.. index:: Time-series dashboards, Grafana dashboards, ElasticSearch
## Grafana Time-series dashboards

Grafana dashboards are available from MFADMIN :index:`Grafana GUI Interface` which is displayed through HTTP on `http://{your_mfadmin_host}:15602`(default login is `admin/admin`), e.g. http://localhost:15602.

![Grafana login](./_images/grafana_login.jpg)

Then, click on the module you want display dashboards.

![Grafana home](./_images/grafana_home.jpg)

- Some default MFDATA dashboards:

![MFDATA dashboards](./_images/grafana_mfdata_dashboard.jpg)

- Some default MFBASE dashboards:

![MFBASE dashboards](./_images/grafana_mfbase_dashboard.jpg)

.. index:: fullres resolution, medres resolution, lowres resolution

.. important::
    | Grafana dashboards have a :index:`resolution` parameter (:index:`retention policies`). 
    | You can choose which resolution to display. See :ref:`mfadmin_miscellaneous:InfluxDB retention policies and statistics aggregator` for more details.

![Grafana resolution dashboards](./_images/grafana_resolution_dashboard.jpg)

.. tip::
    You may want to implement your own dashboard with specific metrics. In order to do this, you may refer to :ref:`mfadmin_miscellaneous:Create specific dashboards` and the :ref:`mfdata_additional_tutorials:Implement custom monitoring and metrics in a plugin`.

.. tip::
    | You can implement your own dashboard from ElasticSearch database. 
    | By default ElasticSearch `mflog <https://github.com/metwork-framework/mflog>`_ logs and ElasticSearch **nginx access logs** datasources are configured in Grafana.
    | When you create your Grafana query, select either the `es_mflog` or `es_nginx` datasource in the `Queries to` field.
    
![Grafana queries datasources](./_images/grafana_queries_datasources.jpg)

.. seealso::
    | `Grafana documentation <https://grafana.com/docs/>`_
    | `Grafana - Getting started guide <https://grafana.com/docs/guides/getting_started>`_  
    | `Using InfluxDB in Grafana <https://grafana.com/docs/features/datasources/influxdb>`_  
    | `Using Elasticsearch in Grafana <https://grafana.com/docs/features/datasources/elasticsearch/>`_

.. index:: Logs dashboards, Kibana dashboards, ElasticSearch
## Kibana dashboards

Kibana dashboards are available from MFADMIN :index:`Kibana GUI Interface` which is displayed through HTTP on `http://{your_mfadmin_host}:15605` from a remote host and also `http://localhost:156054` from the MFADMIN local host. The default login is `admin/admin`.


After you logged in to Kibana, click the `Dashboard` menu to select available dashboards to display.

The default dashboards provided by MetWork are:
- :ref:`mflog logs <mfadmin_monitoring_plugins:Enable monitoring based on standard logs and mflog logs>`
- :ref:`nginx logs <mfadmin_monitoring_plugins:Enable monitoring based on nginx access logs>`

![Kibana available dashboards](./_images/kibana_available_dashboards.jpg)


### mflog logs dashboards example

![Kibana mflog logs dashboards](./_images/kibana_mflog_logs_dashboard.jpg)

### nginx logs dashboards example

:ref:`nginx logs dashboards<mfadmin_monitoring_plugins:Enable monitoring based on nginx access logs>` are similar to :ref:`mflog logs <mfadmin_monitoring_plugins:Enable monitoring based on standard logs and mflog logs>` dashboards, except data displayed.

![Kibana mflog logs dashboards](./_images/kibana_nginx_logs_dashboard.jpg)

.. index:: Edit Kibana dashboard
### Editing a Kibana dashboard visualization

In this section:
- we will add some attributes the logger of the a :ref:`move_image plugin <mfdata:mfdata_quick_start:Create the plugin>`, based on the `mflog example <https://github.com/metwork-framework/mflog#what-is-it->`)
- we will edit a Kibana `mflog logs` dashboard visualization in order to add the added attributes to be displayed.

Edit the `main.py` script of the :ref:`move_image plugin <mfdata:mfdata_quick_start:Create the plugin>`, and change as following:

```python
#!/usr/bin/env python3

from acquisition import AcquisitionMoveStep
from mflog import get_logger


class Move_imageMoveMainStep(AcquisitionMoveStep):

    plugin_name = "move_image"
    step_name = "main"
    log = get_logger("move_image")
    log = log.bind(user="john")
    log = log.bind(user_id=123)

    def process(self, xaf):
        self.log.warning("user logged in", happy=True, another_key=42)
        return super().process(xaf)


if __name__ == "__main__":
    x = Move_imageMoveMainStep()
    x.run()


```
Then, run the plugin.

Open the MFADMIN Kibana GUI Interface and display the `mflog logs` dashboard.

In the menu bar, click **Edit**.

To edit a visualisation of a panel, click the **gear icon** in the upper right. So, click the **gear icon** in the upper right of the `mflog logs` panel:, then click `edit visualization`:

![Kibana mflog edit visualisation 1](./_images/kibana_edit_visu1.jpg)

Add the attributes:
![Kibana mflog edit visualisation 2](./_images/kibana_edit_visu2.jpg)

Click **Save** in the menu bar, and enter a new name, e.g. **mflog logs custom**

Add filters: `plugins:"move_image"` and `level:"warning"`:

![Kibana mflog edit visualisation 3](./_images/kibana_edit_visu3.jpg)

.. seealso::
    | For further, refer to `Kibana documentation <https://www.elastic.co/guide/en/kibana/current>`_   


.. note::
    You may edit any Kibana dashboards, either data table or graphs.
    
<!--
Intentional comment to prevent m2r from generating bad rst statements when the file ends with a block .. xxx ::
-->
