################################################################################
#
# python-intelhex
#
################################################################################

PYTHON_INTELHEX_VERSION = 2.2.1
PYTHON_INTELHEX_SOURCE = intelhex-$(PYTHON_INTELHEX_VERSION).tar.gz
PYTHON_INTELHEX_SITE = git://github.com/python-intelhex/intelhex
PYTHON_INTELHEX_SETUP_TYPE = setuptools
PYTHON_INTELHEX_LICENSE = BSD
HOST_PYTHON_INTELHEX_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
