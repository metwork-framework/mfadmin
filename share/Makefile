include ../adm/root.mk
include $(MFEXT_HOME)/share/subdir_root.mk
include $(MFCOM_HOME)/share/config_subdir.mk

TARGET_WWW=$(MODULE_HOME)/share/www

all:: $(TARGET_WWW)

clean::
	rm -rf $(TARGET_WWW)

$(MODULE_HOME)/share/www:
	mkdir -p $@
	cp -rf www/* $@
