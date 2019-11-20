CONFIGS=config.ini influxdb.conf grafana.ini elasticsearch.conf elasticsearch_jvm_options.conf elasticsearch_log4j2_properties.conf mflog_override.conf kibana.conf nginx.conf

include ../adm/root.mk
include $(MFEXT_HOME)/share/subdir_root.mk
include $(MFEXT_HOME)/share/config_subdir.mk

GRAFANA_DASHBOARDS=$(wildcard grafana_dashboards/*.json)
KIBANA_DASHBOARDS=$(wildcard kibana_dashboards/*.json)
TARGET_GRAFANA_DASHBOARDS=$(addprefix $(MFMODULE_HOME)/config/,$(GRAFANA_DASHBOARDS))
TARGET_KIBANA_DASHBOARDS=$(addprefix $(MFMODULE_HOME)/config/,$(KIBANA_DASHBOARDS))

all:: $(MFMODULE_HOME)/config/circus.ini $(MFMODULE_HOME)/config/telegraf.conf $(MFMODULE_HOME)/config/grafana_provisioning/datasources/datasource.yaml $(MFMODULE_HOME)/config/grafana_provisioning/dashboards/dashboard.yaml $(TARGET_GRAFANA_DASHBOARDS) $(TARGET_KIBANA_DASHBOARDS)

# because of a problem with the subdir_root.mk default rule overriding
$(PREFIX)/config/%: %

$(MFMODULE_HOME)/config/%.ini: %.ini
	@mkdir -p $(shell dirname $@)
	cp -f $< $@

$(MFMODULE_HOME)/config/%.conf: %.conf
	@mkdir -p $(shell dirname $@)
	cp -f $< $@

$(MFMODULE_HOME)/config/grafana_dashboards/%.json: grafana_dashboards/%.json
	@mkdir -p $(MFMODULE_HOME)/config/grafana_dashboards
	cat $< |sed 's/.{DS_INFLUXDB}/influxdb/g' |sed 's/DS_INFLUXDB/influxdb/g' >$@ || { rm -f $@ ; false ; }

$(MFMODULE_HOME)/config/kibana_dashboards/%.json: kibana_dashboards/%.json
	@mkdir -p $(MFMODULE_HOME)/config/kibana_dashboards
	cat $< |envtpl --reduce-multi-blank-lines >$@ || { rm -f $@ ; false ; }

$(MFMODULE_HOME)/config/grafana_provisioning/datasources/datasource.yaml: grafana_provisioning/datasources/datasource.yaml
	mkdir -p `dirname $@`
	cp -f $< $@

$(MFMODULE_HOME)/config/grafana_provisioning/dashboards/dashboard.yaml: grafana_provisioning/dashboards/dashboard.yaml
	mkdir -p `dirname $@`
	cp -f $< $@
