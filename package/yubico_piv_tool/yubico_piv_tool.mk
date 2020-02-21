################################################################################
#
# yubico_piv_tool
#
################################################################################

YUBICO_PIV_TOOL_VERSION = yubico-piv-tool-2.0.0
YUBICO_PIV_TOOL_SITE = git://github.com/Yubico/yubico-piv-tool.git
YUBICO_PIV_TOOL_LICENSE = BSD
YUBICO_PIV_TOOL_LICENSE_FILES = COPYING
YUBICO_PIV_TOOL_DEPENDENCIES = host-gengetopt

YUBICO_PIV_TOOL_AUTORECONF = YES
YUBICO_PIV_TOOL_DEPENDENCIES = libtool

$(eval $(autotools-package))
