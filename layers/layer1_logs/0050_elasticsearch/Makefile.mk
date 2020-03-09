include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=elasticsearch
export VERSION=7.6.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export ARCHIVE=elasticsearch-7.6.1-linux-x86_64.tar.gz
export CHECKSUM=9592ab1848c132c18c76dbbac91c19d6
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
