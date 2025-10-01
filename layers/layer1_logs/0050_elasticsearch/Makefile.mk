include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=elasticsearch
export VERSION=8.18.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=60561954bc33816636f1a30a7c73b840
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
	#Remove modules/x-pack-ml for a lighter rpm
	rm -rf $(PREFIX)/opt/elasticsearch/modules/x-pack-ml
	#Also remove modules/x-pack-esql and x-pack-esql-core (requiring x-pack-ml)
	rm -rf $(PREFIX)/opt/elasticsearch/modules/x-pack-esql
	rm -rf $(PREFIX)/opt/elasticsearch/modules/x-pack-esql-core
	#Remove modules/repository-s3 generating errors
	rm -rf $(PREFIX)/opt/elasticsearch/modules/repository-s3
