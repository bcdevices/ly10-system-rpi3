################################################################################
#
# openocd-riscv
#
################################################################################

OPENOCD_RISCV_VERSION = b8620764c09cbb05d8179fd5f520110fee114417
OPENOCD_RISCV_SITE = git://github.com/riscv/riscv-openocd.git
OPENOCD_RISCV_GIT_SUBMODULES = YES

OPENOCD_RISCV_AUTORECONF = YES
OPENOCD_RISCV_DEPENDENCIES = libusb-compat
OPENOCD_RISCV_DEPENDENCIES += libftdi
OPENOCD_RISCV_DEPENDENCIES += hidapi

OPENOCD_RISCV_CONF_OPTS += --prefix=/usr/local/riscv/openocd
OPENOCD_RISCV_CONF_OPTS += --enable-ftdi
OPENOCD_RISCV_CONF_OPTS += --disable-doxygen-html
OPENOCD_RISCV_CONF_OPTS += --enable-cmsis-dap
OPENOCD_RISCV_CONF_OPTS += --enable-jlink
OPENOCD_RISCV_CONF_OPTS += --enable-stlink
OPENOCD_RISCV_CONF_OPTS += --includedir=$(STAGING_DIR)/usr/include/libusb-1.0
OPENOCD_RISCV_CONF_OPTS += --with-jim-shared=no
OPENOCD_RISCV_CONF_OPTS += --disable-shared
OPENOCD_RISCV_CONF_OPTS += --enable-dummy
OPENOCD_RISCV_CONF_OPTS += --disable-werror

define OPENOCD_RISCV_BOOTSTRAP
	rm -rf $(@D)/src/jtag/drivers/libjaylink
	git -C $(@D)/src/jtag/drivers clone http://repo.or.cz/r/libjaylink.git
endef

define OPENOCD_RISCV_TARGET_RENAME
	mv $(TARGET_DIR)/usr/bin/openocd $(TARGET_DIR)/usr/bin/openocd_riscv
endef


OPENOCD_RISCV_PRE_PATCH_HOOKS += OPENOCD_RISCV_BOOTSTRAP
OPENOCD_RISCV_POST_INSTALL_TARGET_HOOKS += OPENOCD_RISCV_TARGET_RENAME

$(eval $(autotools-package))
