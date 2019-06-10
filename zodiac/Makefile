CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
INCLUDES  = 
LDFLAGS   = $(shell sst-config --ELEMENT_LDFLAGS)
LIBRARIES =

SRC = $(wildcard *.cc)
#Exclude these files from default compilation
SRCS = $(filter-out dumpireader.cc zdumpi.cc otfreader.cc zotf.cc, $(SRC))
OBJ = $(SRCS:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all checkOptions install uninstall clean

thornhill ?= $(shell sst-config thornhill thornhill_LIBDIR)

all: checkOptions install

checkOptions:
ifeq ($(thornhill),)
	$(error thornhill Environment variable needs to be defined, ex: "make thornhill=/path/to/thornhill")
endif
ifdef dumpi
    INCLUDES  += -I$(dumpi)
    LIBRARIES += -L$(dumpi) -ldumpi
    $(shell sst-register dumpi dumpi_LIBDIR=$(dumpi))
    SRCS += dumpireader.cc zdumpi.cc
endif
ifdef otf
    INCLUDES  += -I$(otf)
    LIBRARIES += -L$(otf) -lotf
    $(shell sst-register otf otf_LIBDIR=$(otf))
    SRCS += otfreader.cc zotf.cc
endif

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -I$(thornhill) $(INCLUDES) -MMD -c $< -o $@

libzodiac.so: $(OBJ)
	$(CXX) $(CXXFLAGS) -I$(thornhill) $(INCLUDES) $(LDFLAGS) -o $@ $^ -L$(thornhill) $(LIBRARIES) -lthornhill

install: libzodiac.so
	sst-register zodiac zodiac_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u zodiac

clean: uninstall
	rm -rf .build libzodiac.so
