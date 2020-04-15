################################################################################
#
# python-pyocd
#
################################################################################
PYTHON_PYOCD_VERSION = 0.25.0
PYTHON_PYOCD_SOURCE = v$(PYTHON_PYOCD_VERSION).tar.gz
PYTHON_PYOCD_SOURCE = pyocd-$(PYTHON_PYOCD_VERSION).tar.gz
PYTHON_PYOCD_SITE = git://github.com/mbedmicro/pyOCD
PYTHON_PYOCD_SETUP_TYPE = setuptools
PYTHON_PYOCD_LICENSE = Apache-2.0
PYTHON_PYOCD_LICENSE_FILES = LICENSE

$(eval $(python-package))
