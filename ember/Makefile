CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cc */*.cc */*/*.cc)
#Exclude these files from default compilation
SRCS = $(filter-out \
    sirius/libsirius/libsirius.cc \
    tools/meshconverter/meshconverter.cc \
    tools/spygen/spygen.cc \
    mpi/motifs/emberotf2.cc \
, $(SRC))
OBJ = $(SRCS:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all checkOptions install uninstall clean

thornhill ?= $(shell sst-config thornhill thornhill_LIBDIR)

all: checkOptions install

checkOptions:
ifeq ($(thornhill),)
	$(error thornhill Environment variable needs to be defined, ex: "make thornhill=/path/to/thornhill")
endif

tools/%/%: tools/%/%.cc
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -I$(thornhill) -MMD -c $< -o $@

libember.so: $(OBJ)
	cd sirius/libsirius && $(MAKE)
	$(CXX) $(CXXFLAGS) -I$(thornhill) $(LDFLAGS) -o $@ $^ sirius/libsirius/libsirius.so

install: tools/meshconverter/meshconverter tools/spygen/spygen libember.so
	sst-register ember ember_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u ember

clean: uninstall
	cd sirius/libsirius && $(MAKE) clean
	rm -rf .build libember.so tools/meshconverter/meshconverter tools/spygen/spygen
