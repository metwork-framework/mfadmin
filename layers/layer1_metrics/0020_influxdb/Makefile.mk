include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=influxdb2
export VERSION=2.7.12
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=09ce88f95f42e311d8cd92c0df0d08b2
DESCRIPTION=\
INFLUXDB is an open source time series database with no external dependencies. It's useful for recording metrics, events, and performing analytics
WEBSITE=https://www.influxdata.com
LICENSE=MIT

all:: $(PREFIX)/bin/influxd
$(PREFIX)/bin/influxd:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	if ! test -d $(PREFIX)/bin; then mkdir -p $(PREFIX)/bin; fi
	cd build/$(NAME)-$(VERSION)/usr/bin && cp influxd $(PREFIX)/bin
