################################################################################
#
# exodriver
#
################################################################################

EXODRIVER_VERSION = 2.5.3
EXODRIVER_SOURCE = v$(EXODRIVER_VERSION).tar.gz
EXODRIVER_SITE = https://github.com/labjack/exodriver/archive
EXODRIVER_LICENSE = MIT X11
EXODRIVER_DEPENDENCIES =
EXODRIVER_INSTALL_STAGING = YES

define EXODRIVER_BUILD_CMDS
  $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/liblabjackusb
endef

define EXODRIVER_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 755 $(@D)/liblabjackusb/liblabjackusb.so.$(EXODRIVER_VERSION) $(STAGING_DIR)/usr/lib/liblabjackusb.so
endef

define EXODRIVER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/liblabjackusb/liblabjackusb.so.$(EXODRIVER_VERSION) $(TARGET_DIR)/usr/lib/liblabjackusb.so
endef

$(eval $(generic-package))
