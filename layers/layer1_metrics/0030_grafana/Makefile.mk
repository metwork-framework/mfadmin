include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=grafana
export VERSION=6.1.1
export EXTENSION=tar.gz
export CHECKTYPE=SHA256
export CHECKSUM=5c17e57adc6e48f3c9123062f4bdaef849fb4d978b0a9ff0eb8b7cf147c57835
DESCRIPTION=\
GRAFANA is an open source software for time series analytics
WEBSITE=https://grafana.com
LICENSE=Apache 2.0 License

all:: $(PREFIX)/opt/grafana/bin/grafana-server
$(PREFIX)/opt/grafana/bin/grafana-server:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	mkdir -p $(PREFIX)/opt/grafana/plugins
	cd build/$(NAME)-$(VERSION) && cp -R * $(PREFIX)/opt/grafana/
	# FIXME: tmp fix for https://github.com/grafana/grafana/issues/15524
	sed -i 's/.panel-editor__scroll{min-width:0;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;min-height:0}/.panel-editor__scroll{min-width:0;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex}/g' $(PREFIX)/opt/grafana/public/build/grafana.dark.15bb4924c84358f66b22.css
	sed -i 's/.panel-editor__scroll{min-width:0;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;min-height:0}/.panel-editor__scroll{min-width:0;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex}/g' $(PREFIX)/opt/grafana/public/build/grafana.light.15bb4924c84358f66b22.css
