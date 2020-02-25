include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=grafana
export VERSION=6.6.1
export EXTENSION=tar.gz
export CHECKTYPE=SHA256
export CHECKSUM=0edc8207e356ef66eb7b1c78a1cdabc2cd5c0655de774000de2ad0397e543377
DESCRIPTION=\
GRAFANA is an open source software for time series analytics
WEBSITE=https://grafana.com
LICENSE=Apache 2.0 License

all:: $(PREFIX)/opt/grafana/bin/grafana-server
$(PREFIX)/opt/grafana/bin/grafana-server:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/opt/grafana/plugins
	cd build/$(NAME)-$(VERSION) && cp -R * $(PREFIX)/opt/grafana/
