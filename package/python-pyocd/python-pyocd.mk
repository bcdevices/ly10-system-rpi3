################################################################################
#
# python-pyocd
#
################################################################################

PYTHON_PYOCD_VERSION = 0.25.0
PYTHON_PYOCD_SOURCE = pyocd-$(PYTHON_PYOCD_VERSION).tar.gz
PYTHON_PYOCD_SITE = https://files.pythonhosted.org/packages/24/31/1d0a18a9cd5bd683d1ac75a18d4ae9ba8d806861f49a5c70431f86c940f7
PYTHON_PYOCD_SETUP_TYPE = setuptools
PYTHON_PYOCD_LICENSE = Apache-2.0
PYTHON_PYOCD_LICENSE_FILES = LICENSE

$(eval $(python-package))
