include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=kibana
export VERSION=8.19.23
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=58a64619aa99a9e78544a8e0fa4c126c
DESCRIPTION=\
kibana is a log ui for elasticsearch
WEBSITE=https://www.elastic.co/products/kibana
LICENSE=Apache

all:: $(PREFIX)/opt/kibana/bin/kibana
$(PREFIX)/opt/kibana/bin/kibana:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	rm -Rf $(PREFIX)/opt/kibana
	mkdir -p $(PREFIX)/opt
	cd build && cp -Rf $(NAME)-$(VERSION) $(PREFIX)/opt/kibana

