include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=grafana
export VERSION=5.4.2
export EXTENSION=tar.gz
export CHECKTYPE=SHA256
export CHECKSUM=6228b755fb07d76f8b47f489c07a45af1c64fa9edfb2dc232b2f05431006f866
DESCRIPTION=\
GRAFANA is an open source software for time series analytics
WEBSITE=https://grafana.com
LICENSE=Apache 2.0 License

all:: $(PREFIX)/opt/grafana/bin/grafana-server
$(PREFIX)/opt/grafana/bin/grafana-server:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/opt/grafana/plugins
	cd build/$(NAME)-$(VERSION) && cp -R * $(PREFIX)/opt/grafana/
