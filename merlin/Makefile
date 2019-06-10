CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cc */*.cc)
#Exclude these files from default compilation
SRCS = $(filter-out boostExports.cc, $(SRC))
OBJ = $(SRCS:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all install uninstall clean

all: install

pymerlin.inc: pymerlin.py
	rm -f .build/merlin.o
	od -v -t x1 < $< | sed -e 's/^[^ ]*[ ]*//g' -e '/^\s*$$/d' -e 's/\([0-9a-f]*\)[ $$]*/0x\1,/g' > $@

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

libmerlin.so: $(OBJ)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

install: pymerlin.inc libmerlin.so
	sst-register merlin merlin_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u merlin

clean: uninstall
	rm -rf .build libmerlin.so pymerlin.inc
