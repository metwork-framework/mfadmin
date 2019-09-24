BINS=before_start_influxdb before_start_grafana _wait_grafana.py _wait_influxdb.py _provision_home_dashboard.py _force_grafana_admin_password.sh before_start_elasticsearch before_start_kibana elasticsearch.clean _wait_es.py _wait_kibana.py _provision_nginx_template.py _make_nginx_conf _provision_mflog_template.py export_kibana_dashboard.py import_kibana_dashboard.py _provision_kibana_dashboards

include root.mk
include $(MFEXT_HOME)/share/subdir_root.mk
include $(MFCOM_HOME)/share/startup_scripts_profiles.mk

all:: $(PREFIX)/share/welcome/index.html

$(PREFIX)/share/welcome/index.html: welcome/index.html
	rm -Rf $(PREFIX)/share/welcome
	mkdir -p $(PREFIX)/share/welcome
	cp -Rf welcome/* $(PREFIX)/share/welcome/
