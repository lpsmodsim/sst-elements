thornhill ?= $(shell sst-config thornhill thornhill_LIBDIR)

.PHONY: all install uninstall clean

all: install

install:
	sst-register hermes hermes_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u hermes

clean: uninstall
