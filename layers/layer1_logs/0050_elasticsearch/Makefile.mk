include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=elasticsearch
export VERSION=6.5.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=23e9cf99b88b4d3c8f638b2b2f717c29
DESCRIPTION=\
Elasticsearch is a distributed, RESTful search and analytics engine
WEBSITE=https://www.elastic.co/products/elasticsearch
LICENSE=Apache

all:: $(PREFIX)/opt/elasticsearch/bin/elasticsearch
$(PREFIX)/opt/elasticsearch/bin/elasticsearch:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	rm -Rf $(PREFIX)/opt/elasticsearch
	mkdir -p $(PREFIX)/opt
	cd build && cp -Rf $(NAME)-$(VERSION) $(PREFIX)/opt/elasticsearch
