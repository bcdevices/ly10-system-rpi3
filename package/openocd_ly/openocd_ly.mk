################################################################################
#
# openocd-ly
#
################################################################################

OPENOC_LY_VERSION = 6d390e1b2a393505b38e1d0fcd741cd0b1cf92aa
OPENOC_LY_SITE = git://github.com/ntfreak/openocd
OPENOC_LY_GIT_SUBMODULES = YES

OPENOC_LY_AUTORECONF = YES
OPENOC_LY_DEPENDENCIES = libusb-compat
OPENOC_LY_DEPENDENCIES += libftdi

OPENOC_LY_CONF_OPTS += --enable-ftdi
OPENOC_LY_CONF_OPTS += --disable-doxygen-html
OPENOC_LY_CONF_OPTS += --includedir=$(STAGING_DIR)/usr/include/libusb-1.0
OPENOC_LY_CONF_OPTS += --with-jim-shared=no
OPENOC_LY_CONF_OPTS += --disable-shared
OPENOC_LY_CONF_OPTS += --enable-dummy
OPENOC_LY_CONF_OPTS += --disable-werror

$(eval $(autotools-package))
