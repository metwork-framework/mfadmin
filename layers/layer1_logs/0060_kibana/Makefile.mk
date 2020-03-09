include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=kibana
export VERSION=7.6.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export ARCHIVE=kibana-7.6.1-linux-x86_64.tar.gz
export CHECKSUM=0830c16a018182327bf464fdfe71508a
DESCRIPTION=\
kibana is a log ui for elasticsearch
WEBSITE=https://www.elastic.co/products/kibana
LICENSE=Apache

all:: $(PREFIX)/opt/kibana/bin/kibana
$(PREFIX)/opt/kibana/bin/kibana:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	rm -Rf $(PREFIX)/opt/kibana
	mkdir -p $(PREFIX)/opt
	cd build && cp -Rf $(NAME)-$(VERSION)-linux-x86_64 $(PREFIX)/opt/kibana
