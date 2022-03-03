include ../../../adm/root.mk
include $(MFEXT_HOME)/share/simple_layer.mk

all:: $(PREFIX)/repaire $(PREFIX)/start.sh

$(PREFIX)/start.sh: start.sh
	cp -f $< $@
	chmod +x $@

$(PREFIX)/repaire:
	rm -Rf $(PREFIX)/repaire
	cp -Rf repaire $(PREFIX)/repaire
