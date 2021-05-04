include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=influxdb
export VERSION=1.7.9-1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=f7796c193739367b02b53cc7a9000d83
DESCRIPTION=\
INFLUXDB is an open source time series database with no external dependencies. It's useful for recording metrics, events, and performing analytics
WEBSITE=https://www.influxdata.com
LICENSE=MIT

all:: $(PREFIX)/bin/influx
$(PREFIX)/bin/influx:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	if ! test -d $(PREFIX)/bin; then mkdir -p $(PREFIX)/bin; fi
	cd build/$(NAME)-$(VERSION)/usr/bin && cp influx* $(PREFIX)/bin
	if ! test -d $(PREFIX)/config; then mkdir -p $(PREFIX)/config; fi
	cd build/$(NAME)-$(VERSION)/etc/influxdb && cp influxdb.conf $(PREFIX)/config
	if ! test -d $(PREFIX)/share/man/man1; then mkdir -p $(PREFIX)/share/man/man1; fi
	cd build/$(NAME)-$(VERSION) && cp usr/share/man/man1/* $(PREFIX)/share/man/man1
