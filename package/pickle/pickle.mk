################################################################################
#
# pickle
#
################################################################################

#PICKLE_VERSION = 1170
#PICKLE_VERSION = 1170:fbbf5e9d1fd1
PICKLE_VERSION = fbbf5e9d1fd1
PICKLE_SITE = http://hg.kewl.org/pub/pickle
PICKLE_SITE_METHOD = hg
PICKLE_LICENSE = GPL-3.0
PICKLE_LICENSE_FILES = pickle/COPYING
#PICKLE_SUBDIR = pickle
PICKLE_AUTORECONF = NO
#PICKLE_DEPENDENCIES =

ifeq ($(BR2_PACKAGE_LIBFTDI1),y)
PICKLE_DEPENDENCIES += libftdi1
else ifeq ($(BR2_PACKAGE_LIBFTDI),y)
PICKLE_DEPENDENCIES += libftdi
endif

define PICKLE_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) build
endef

#define PICKLE_INSTALL_STAGING_CMDS
#    $(INSTALL) -D -m 0755 $(@D)/libfoo.a $(STAGING_DIR)/usr/lib/libfoo.a
#    $(INSTALL) -D -m 0644 $(@D)/foo.h $(STAGING_DIR)/usr/include/foo.h
#    $(INSTALL) -D -m 0755 $(@D)/libfoo.so* $(STAGING_DIR)/usr/lib
#endef

define PICKLE_INSTALL_TARGET_CMDS
    $(INSTALL) -d -g0 -m0755 -o0 $(TARGET_DIR)/usr/bin
    $(INSTALL) -D -m 4755 $(@D)/pickle $(TARGET_DIR)/usr/bin
    ln -sf $(TARGET_DIR)/usr/bin/pickle $(TARGET_DIR)/usr/bin/p12
    ln -sf $(TARGET_DIR)/usr/bin/pickle $(TARGET_DIR)/usr/bin/p14
    ln -sf $(TARGET_DIR)/usr/bin/pickle $(TARGET_DIR)/usr/bin/n14
    ln -sf $(TARGET_DIR)/usr/bin/pickle $(TARGET_DIR)/usr/bin/p16
    ln -sf $(TARGET_DIR)/usr/bin/pickle $(TARGET_DIR)/usr/bin/n16
    ln -sf $(TARGET_DIR)/usr/bin/pickle $(TARGET_DIR)/usr/bin/p24
    ln -sf $(TARGET_DIR)/usr/bin/pickle $(TARGET_DIR)/usr/bin/p32
    $(INSTALL) -D -m 4755 $(@D)/pio $(TARGET_DIR)/usr/bin
    $(INSTALL) -D -m 4755 $(@D)/ptest $(TARGET_DIR)/usr/bin
    $(INSTALL) -D -m 4755 $(@D)/pctrl $(TARGET_DIR)/usr/bin
    $(INSTALL) -D -m 4755 $(@D)/pload $(TARGET_DIR)/usr/bin
endef

#define PICKLE_USERS
#    foo -1 libfoo -1 * - - - LibFoo daemon
#endef

#define PICKLE_PERMISSIONS
#    /bin/foo  f  4755  foo  libfoo   -  -  -  -  -
#endef

$(eval $(generic-package))
