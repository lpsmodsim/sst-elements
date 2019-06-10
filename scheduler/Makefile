CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cc */*.cc)
OBJ = $(SRC:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all install uninstall clean

all: install

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -I. -MMD -c $< -o $@

libscheduler.so: $(OBJ)
	$(CXX) $(CXXFLAGS) -I. $(LDFLAGS) -o $@ $^

install: libscheduler.so
	sst-register scheduler scheduler_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u scheduler

clean: uninstall
	rm -rf .build libscheduler.so
