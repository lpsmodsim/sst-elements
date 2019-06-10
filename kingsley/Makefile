CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cc)
OBJ = $(SRC:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all install uninstall clean

all: install

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

libkingsley.so: $(OBJ)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

install: libkingsley.so
	sst-register kingsley kingsley_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u kingsley

clean: uninstall
	rm -rf .build libkingsley.so
