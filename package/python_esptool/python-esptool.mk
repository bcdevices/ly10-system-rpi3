############################################################
#
# python-esptool
#
############################################################

PYTHON_ESPTOOL_VERSION = v2.6
PYTHON_ESPTOOL_SOURCE = $(ESPTOOL_VERSION).tar.gz
PYTHON_ESPTOOL_SITE =  git://github.com/espressif/esptool
PYTHON_ESPTOOL_SETUP_TYPE = setuptools

$(eval $(python-package))
