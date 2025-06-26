include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=logcli
export VERSION=3.5.1
export EXTENSION=zip
export CHECKTYPE=MD5
export CHECKSUM=9030a1b20a93053dd6014cd26874c857
DESCRIPTION=\
little loki cli client
WEBSITE=https://grafana.com/oss/loki/
LICENSE=Apache 2.0

all:: $(PREFIX)/bin/logcli
$(PREFIX)/bin/logcli:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/bin/ && cd build && cp -r logcli-linux-amd64 $(PREFIX)/bin/logcli
