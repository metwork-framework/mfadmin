include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=logcli
export VERSION=2.1.0
export EXTENSION=zip
export CHECKTYPE=MD5
export CHECKSUM=882c9d8ac49b7ff375ad2798f4c2981b
DESCRIPTION=\
little loki cli client
WEBSITE=https://grafana.com/oss/loki/
LICENSE=Apache 2.0

all:: $(PREFIX)/bin/logcli
$(PREFIX)/bin/logcli:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/bin/ && cd build && cp -r logcli-linux-amd64 $(PREFIX)/bin/logcli
