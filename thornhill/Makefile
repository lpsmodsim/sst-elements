CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cc)
OBJ = $(SRC:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all checkOptions install uninstall clean

miranda ?= $(shell sst-config miranda miranda_LIBDIR)

all: checkOptions install

checkOptions:
ifeq ($(miranda),)
	$(error miranda Environment variable needs to be defined, ex: "make miranda=/path/to/miranda")
endif

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -I$(miranda) -MMD -c $< -o $@

libthornhill.so: $(OBJ)
	$(CXX) $(CXXFLAGS) -I$(miranda) $(LDFLAGS) -o $@ $^ -L$(miranda) -lmiranda

install: libthornhill.so
	sst-register thornhill thornhill_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u thornhill

clean: uninstall
	rm -rf .build libthornhill.so
