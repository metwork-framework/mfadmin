include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=loki
export VERSION=3.5.1
export EXTENSION=zip
export CHECKTYPE=MD5
export CHECKSUM=6e12887f00502ee3aab6224d916d9eb0
DESCRIPTION=\
Loki is a horizontally-scalable, highly-available, multi-tenant log aggregation system inspired by Prometheus.\
It is designed to be very cost effective and easy to operate.\
It does not index the contents of the logs, but rather a set of labels for each log stream.
WEBSITE=https://grafana.com/oss/loki/
LICENSE=Apache 2.0

all:: $(PREFIX)/bin/loki
$(PREFIX)/bin/loki:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/bin/ && cd build && cp -r loki-linux-amd64 $(PREFIX)/bin/loki
