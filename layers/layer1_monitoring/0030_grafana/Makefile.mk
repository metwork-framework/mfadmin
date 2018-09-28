include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=grafana
export VERSION=5.1.3
export EXTENSION=tar.gz
export CHECKTYPE=SHA256
export CHECKSUM=86605013e69ed47bb4a8ee1e2420373edee23a94885c07988152c36fe5ed2d8c
DESCRIPTION=\
GRAFANA is an open source software for time series analytics
WEBSITE=https://grafana.com
LICENSE=Apache 2.0 License

all:: $(PREFIX)/opt/grafana/bin/grafana-server
$(PREFIX)/opt/grafana/bin/grafana-server:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/opt/grafana/plugins
	cd build/$(NAME)-$(VERSION) && cp -R * $(PREFIX)/opt/grafana/
