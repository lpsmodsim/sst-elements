CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cc)
OBJ = $(SRC:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all checkOptions install uninstall clean

memHierarchy ?= $(shell sst-config memHierarchy memHierarchy_LIBDIR)
Opal ?= $(shell sst-config Opal Opal_LIBDIR)

all: checkOptions install

checkOptions:
ifeq ($(memHierarchy),)
	$(error memHierarchy Environment variable needs to be defined, ex: "make memHierarchy=/path/to/memHierarchy")
endif
ifeq ($(Opal),)
	$(error Opal Environment variable needs to be defined, ex: "make Opal=/path/to/Opal")
endif

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -I$(memHierarchy) -I$(Opal) -MMD -c $< -o $@

libSamba.so: $(OBJ)
	$(CXX) $(CXXFLAGS) -I$(memHierarchy) -I$(Opal) $(LDFLAGS) -o $@ $^ -L$(memHierarchy) -L$(Opal) -lmemHierarchy -lOpal

install: libSamba.so
	sst-register Samba Samba_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u Samba

clean: uninstall
	rm -rf .build libSamba.so
