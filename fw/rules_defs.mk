
FPIO_FW_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

ifneq (1,$(RULES))

SRC_DIRS += $(FPIO_FW_DIR)

FPIO_DRV_SRC := $(notdir $(wildcard $(FPIO_FW_DIR)/*.c))

else # Rules

libfpio_uex_drv.o : $(FPIO_DRV_SRC:.c=.o)
	$(Q)$(LD) -r -o $@ $^

endif
