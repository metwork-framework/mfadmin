CONFIGS=config.ini influxdb.conf grafana.ini elasticsearch.conf elasticsearch_jvm_options.conf elasticsearch_log4j2_properties.conf mflog_override.conf kibana.conf nginx.conf

include ../adm/root.mk
include $(MFEXT_HOME)/share/subdir_root.mk
include $(MFCOM_HOME)/share/config_subdir.mk

GRAFANA_DASHBOARDS=$(wildcard grafana_dashboards/*.json)
TARGET_GRAFANA_DASHBOARDS=$(addprefix $(MODULE_HOME)/config/,$(GRAFANA_DASHBOARDS))

all:: $(MODULE_HOME)/config/circus.ini $(MODULE_HOME)/config/telegraf.conf $(MODULE_HOME)/config/grafana_provisioning/datasources/datasource.yaml $(MODULE_HOME)/config/grafana_provisioning/dashboards/dashboard.yaml $(TARGET_GRAFANA_DASHBOARDS)

# because of a problem with the subdir_root.mk default rule overriding
$(PREFIX)/config/%: %

$(MODULE_HOME)/config/%.ini: %.ini
	@mkdir -p $(shell dirname $@)
	cp -f $< $@

$(MODULE_HOME)/config/%.conf: %.conf
	@mkdir -p $(shell dirname $@)
	cp -f $< $@

$(MODULE_HOME)/config/%.json: %.json
	@mkdir -p $(MODULE_HOME)/config/grafana_dashboards
	cat $< |sed 's/.{DS_INFLUXDB}/influxdb/g' |sed 's/DS_INFLUXDB/influxdb/g' >$@ || { rm -f $@ ; false ; }

$(MODULE_HOME)/config/grafana_provisioning/datasources/datasource.yaml: grafana_provisioning/datasources/datasource.yaml
	mkdir -p `dirname $@`
	cp -f $< $@

$(MODULE_HOME)/config/grafana_provisioning/dashboards/dashboard.yaml: grafana_provisioning/dashboards/dashboard.yaml
	mkdir -p `dirname $@`
	cp -f $< $@
