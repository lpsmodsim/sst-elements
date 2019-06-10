CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cc)
#Exclude these files from default compilation
SRCS = $(filter-out nicTester.cc, $(SRC))
OBJ = $(SRCS:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all checkOptions install uninstall clean

thornhill ?= $(shell sst-config thornhill thornhill_LIBDIR)

all: checkOptions install

checkOptions:
ifeq ($(thornhill),)
	$(error thornhill Environment variable needs to be defined, ex: "make thornhill=/path/to/thornhill")
endif

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -I$(thornhill) -MMD -c $< -o $@

libfirefly.so: $(OBJ)
	$(CXX) $(CXXFLAGS) -I$(thornhill) $(LDFLAGS) -o $@ $^ -L$(thornhill) -lthornhill

install: libfirefly.so
	sst-register firefly firefly_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u firefly

clean: uninstall
	rm -rf .build libfirefly.so
