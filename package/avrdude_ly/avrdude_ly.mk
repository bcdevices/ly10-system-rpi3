################################################################################
#
# avrdude
#
################################################################################

AVRDUDE_LY_VERSION = 1429
AVRDUDE_LY_SITE = svn://svn.savannah.nongnu.org/avrdude/trunk
AVRDUDE_LY_SITE_METHOD = svn
AVRDUDE_LY_LICENSE = GPL-2.0+
AVRDUDE_LY_LICENSE_FILES = avrdude/COPYING
AVRDUDE_LY_SUBDIR = avrdude
# Sources coming from git, without generated configure and Makefile.in
# files.
AVRDUDE_LY_AUTORECONF = YES
AVRDUDE_LY_CONF_OPTS = --enable-linuxgpio
AVRDUDE_LY_DEPENDENCIES = elfutils libusb libusb-compat ncurses \
	host-flex host-bison

ifeq ($(BR2_PACKAGE_LIBFTDI1),y)
AVRDUDE_LY_DEPENDENCIES += libftdi1
else ifeq ($(BR2_PACKAGE_LIBFTDI),y)
AVRDUDE_LY_DEPENDENCIES += libftdi
endif

# if /etc/avrdude.conf exists, the installation process creates a
# backup file, which we do not want in the context of Buildroot.
define AVRDUDE_LY_REMOVE_BACKUP_FILE
	$(RM) -f $(TARGET_DIR)/etc/avrdude.conf.bak
endef

AVRDUDE_LY_POST_INSTALL_TARGET_HOOKS += AVRDUDE_LY_REMOVE_BACKUP_FILE

$(eval $(autotools-package))
