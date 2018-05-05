################################################################################
#
# openocd-ly
#
################################################################################

OPENOCD_LY_VERSION = 6d390e1b2a393505b38e1d0fcd741cd0b1cf92aa
OPENOCD_LY_SITE = git://github.com/ntfreak/openocd
OPENOCD_LY_GIT_SUBMODULES = YES

OPENOCD_LY_AUTORECONF = YES
OPENOCD_LY_DEPENDENCIES = libusb-compat
OPENOCD_LY_DEPENDENCIES += libftdi

OPENOCD_LY_CONF_OPTS += --enable-ftdi
OPENOCD_LY_CONF_OPTS += --disable-doxygen-html
OPENOCD_LY_CONF_OPTS += --includedir=$(STAGING_DIR)/usr/include/libusb-1.0
OPENOCD_LY_CONF_OPTS += --with-jim-shared=no
OPENOCD_LY_CONF_OPTS += --disable-shared
OPENOCD_LY_CONF_OPTS += --enable-dummy
OPENOCD_LY_CONF_OPTS += --disable-werror

$(eval $(autotools-package))
