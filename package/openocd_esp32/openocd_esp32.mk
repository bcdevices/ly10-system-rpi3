################################################################################
#
# openocd-esp32
#
################################################################################

OPENOCD_ESP32_VERSION = v0.10.0-esp32-20180418
OPENOCD_ESP32_SOURCE = v$(OPENOCD_ESP32_VERSION).tar.gz
OPENOCD_ESP32_SITE = git://github.com/espressif/openocd-esp32
OPENOCD_ESP32_GIT_SUBMODULES = YES

OPENOCD_ESP32_AUTORECONF = YES
OPENOCD_ESP32_DEPENDENCIES = libusb-compat
OPENOCD_ESP32_DEPENDENCIES += libftdi

OPENOCD_ESP32_CONF_OPTS = --prefix=/usr/local/esp/openocd
OPENOCD_ESP32_CONF_OPTS += --enable-ftdi
OPENOCD_ESP32_CONF_OPTS += $(OPENOCD_ESP32_CFLAGS)
OPENOCD_ESP32_CONF_OPTS += --host=arm-unknown-linux-gnueabihf
OPENOCD_ESP32_CONF_OPTS += --disable-doxygen-html
OPENOCD_ESP32_CONF_OPTS += --includedir=$(STAGING_DIR)/usr/include/libusb-1.0


define OPENOCD_ESP32_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) ./bootstrap nosubmodule )
	(cd $(@D); $(TARGET_MAKE_ENV) ./configure $(TARGET_CONFIGURE_OPTS) $(OPENOCD_ESP32_CONF_OPTS) )
endef

define OPENOCD_ESP32_BUILD_CMDS
	$(MAKE) CFLAGS="-Wno-error -I$(TARGET_DIR)/usr/include/libusb-1.0" -C $(@D)
endef

define OPENOCD_ESP32_INSTALL_TARGET_CMDS
	$(MAKE) CFLAGS="-Wno-error -I$(TARGET_DIR)/usr/include/libusb-1.0" -C $(@D) install
endef

$(eval $(generic-package))
