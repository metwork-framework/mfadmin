include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=influxdb2-client
export VERSION=2.7.5
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=58704181aa79c9aff5c94d18f2ca9a89
DESCRIPTION=\
Use the influx CLI to interact with and manage your InfluxDB instance. Write and query data, generate InfluxDB templates, export data, and more
WEBSITE=https://www.influxdata.com
LICENSE=MIT

all:: $(PREFIX)/bin/influx
$(PREFIX)/bin/influx:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	if ! test -d $(PREFIX)/bin; then mkdir -p $(PREFIX)/bin; fi
	cd build && cp influx $(PREFIX)/bin
