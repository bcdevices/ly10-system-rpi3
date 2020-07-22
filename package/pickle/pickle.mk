################################################################################
#
# pickle
#
################################################################################

#PICKLE_VERSION = 1429
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


