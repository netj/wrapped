# Makefile for creating a set of wrapper commands for non-standard software
# installations that can deal with environment setups specific to each package
#
# For example, when TARGET is set to foo by running make TARGET=foo:
# - a directory named foo/ will be created
# - for every executables under foo.bin/, a wrapper command with the same name
#   will be created under foo/
# - each wrapper command will run foo.env.sh before invoking the actual command
#   in foo.bin/
#
# Otherwise, when no TARGET is specified, wrappers for all *.bin/ directories
# will be created.
#
# Author: Jaeho Shin <netj@cs.stanford.edu>
# Created: 2015-05-13

ifdef TARGET
COMMANDS = $(shell find $(TARGET).bin/* -maxdepth 0 -perm -555)
WRAPPERS = $(COMMANDS:$(TARGET).bin/%=$(TARGET)/%)
# create all wrapper commands as a symlink to the one we produce
wrappers: $(WRAPPERS) $(TARGET).wrapper
$(WRAPPERS):
	ln -sfn ../$(TARGET).wrapper $@
$(TARGET).wrapper: $(TARGET).env.sh $(TARGET).bin
	# the wrapper will be a shebang executable
	echo  >$@ '#!/bin/sh'
	chmod +x $@
	# include the environment setup script first
	cat  >>$@ $<
	# produce a line that invokes the actual command
	echo >>$@ 'exec "$(shell readlink $(TARGET).bin)/$${0##*/}" "$$@"'

else
TARGET_BINS = $(wildcard *.bin)
TARGETS = $(TARGET_BINS:%.bin=%)
wrappers:
	@set -x; \
	for t in $(TARGETS); do mkdir -p $$t; $(MAKE) TARGET=$$t; done

endif
.PHONY: wrappers
