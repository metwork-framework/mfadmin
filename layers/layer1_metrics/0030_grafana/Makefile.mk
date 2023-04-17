include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=grafana
export VERSION=8.5.22
export EXTENSION=tar.gz
export CHECKTYPE=SHA256
export CHECKSUM=94a10da45bb09dca16e1f2d67397d7939c15306d0c2db1f5b3929113008f886e
DESCRIPTION=\
GRAFANA is an open source software for time series analytics
WEBSITE=https://grafana.com
LICENSE=Apache 2.0 License

all:: $(PREFIX)/opt/grafana/bin/grafana-server
$(PREFIX)/opt/grafana/bin/grafana-server:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/opt/grafana/plugins
	cd build/$(NAME)-$(VERSION) && cp -R * $(PREFIX)/opt/grafana/
