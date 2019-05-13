################################################################################
#
# debug-ly
#
################################################################################

define DEBUG_LY_USERS
	debug -1 debug -1 * /root/home/debug - - Local debug
endef

$(eval $(generic-package))

