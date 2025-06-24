include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=grafana
export VERSION=11.6.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=8f6d0c24262d204c76f8b745c5c010fa
export EXPLICIT_NAME=$(NAME)-v$(VERSION)
DESCRIPTION=\
GRAFANA is an open source software for time series analytics
WEBSITE=https://grafana.com
LICENSE=Apache 2.0 License

all:: $(PREFIX)/opt/grafana/bin/grafana-server
$(PREFIX)/opt/grafana/bin/grafana-server:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" download uncompress
	mkdir -p $(PREFIX)/opt/grafana/plugins
	cd build/$(EXPLICIT_NAME) && cp -R * $(PREFIX)/opt/grafana/
