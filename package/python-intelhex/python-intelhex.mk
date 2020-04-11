################################################################################
#
# python-intelhex
#
################################################################################

PYTHON_INTELHEX_VERSION = 2.2.1
PYTHON_INTELHEX_SOURCE = intelhex-$(PYTHON_INTELHEX_VERSION).tar.gz
PYTHON_INTELHEX_SITE = https://files.pythonhosted.org/packages/01/66/8fab869edcc0eaf8fc030472ff379b8eeee2ef3b42f8aec6bd84e9f735e3
PYTHON_INTELHEX_SETUP_TYPE = setuptools
PYTHON_INTELHEX_LICENSE = BSD

PYTHON_INTELHEX_SETUP_TYPE = setuptools
PYTHON_INTELHEX_BUILD_OPTS2 =

PYTHON_INTELHEX_BASE_INSTALL_TARGET_OPTS = --prefix=/usr --single-version-externally-managed --root=/home/eric/Documents/projects/ly10/ly10-system-rpi3/.nerves/artifacts/ly10_system_rpi3-portable-0.10.1/target

define PYTHON_INTELHEX_BUILD_CMDS
	cd $(PYTHON_INTELHEX_BUILDDIR); \
		$(PYTHON_INTELHEX_BASE_ENV) $(PYTHON_INTELHEX_ENV) \
		$(PYTHON_INTELHEX_PYTHON_INTERPRETER) setup.py build_ext \
		$(PYTHON_INTELHEX_BASE_BUILD_OPTS) $(PYTHON_INTELHEX_BUILD_OPTS)
endef

define PYTHON_INTELHEX_INSTALL_TARGET_CMDS
  echo "$(PYTHON_INTELHEX_BASE_INSTALL_TARGET_OPTS2)"
  echo "$(PYTHON_INTELHEX__INSTALL_TARGET_OPTS)"
	cd $(PYTHON_INTELHEX_BUILDDIR); \
		$(PYTHON_INTELHEX_BASE_ENV) $(PYTHON_INTELHEX_ENV) \
		$(PYTHON_INTELHEX_PYTHON_INTERPRETER) setup.py build_ext \
		$(PYTHON_INTELHEX_BUILD_OPTS) install \
		$(PYTHON_INTELHEX_BASE_INSTALL_TARGET_OPTS2) \
		$(PYTHON_INTELHEX_INSTALL_TARGET_OPTS)
endef


$(eval $(python-package))
