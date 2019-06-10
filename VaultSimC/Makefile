CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cpp)
OBJ = $(SRC:%.cpp=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all checkOptions install uninstall clean

memHierarchy ?= $(shell sst-config memHierarchy memHierarchy_LIBDIR)

all: checkOptions install

checkOptions:
ifeq ($(memHierarchy),)
	$(error memHierarchy Environment variable needs to be defined, ex: "make memHierarchy=/path/to/memHierarchy")
endif

-include $(DEP)
.build/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -I$(memHierarchy) -MMD -c $< -o $@

libVaultSimC.so: $(OBJ)
	$(CXX) $(CXXFLAGS) -I$(memHierarchy) $(LDFLAGS) -o $@ $^ -L$(memHierarchy) -lmemHierarchy

install: libVaultSimC.so
	sst-register VaultSimC VaultSimC_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u VaultSimC

clean: uninstall
	rm -rf .build libVaultSimC.so
