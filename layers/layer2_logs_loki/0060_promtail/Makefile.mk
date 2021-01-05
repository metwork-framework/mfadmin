include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=promtail
export VERSION=2.1.0
export EXTENSION=zip
export CHECKTYPE=MD5
export CHECKSUM=27d29b51fd96fcbd278f498dbe4d9e52
DESCRIPTION=\
Promtail is an agent which ships the contents of local logs to a private Loki instance or Grafana Cloud.\
It is usually deployed to every machine that has applications needed to be monitored.
WEBSITE=https://grafana.com/docs/loki/latest/clients/promtail/
LICENSE=Apache 2.0

all:: $(PREFIX)/bin/promtail
$(PREFIX)/bin/promtail:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/bin/ && cd build && cp -r promtail-linux-amd64 $(PREFIX)/bin/promtail
