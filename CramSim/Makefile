CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cpp)
#Exclude these files from default compilation
SRCS = $(filter-out TxnDispatcher.cpp, $(SRC))
OBJ = $(SRCS:%.cpp=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all install uninstall clean

all: install

-include $(DEP)
.build/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

libCramSim.so: $(OBJ)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

install: libCramSim.so
	sst-register CramSim CramSim_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u CramSim

clean: uninstall
	rm -rf .build libCramSim.so
