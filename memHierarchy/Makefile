CXX = $(shell sst-config --CXX)
CXXFLAGS  = $(shell sst-config --ELEMENT_CXXFLAGS)
INCLUDES  = -I.
LDFLAGS   = $(shell sst-config --ELEMENT_LDFLAGS)
LIBRARIES =

SRC = $(wildcard *.cc */*.cc)
#Exclude these files from default compilation
SRCS = $(filter-out \
    memNetBridge.cc \
    Sieve/sieveController.cc \
    Sieve/sieveFactory.cc \
    Sieve/broadcastShim.cc \
    Sieve/memmgr_sieve.cc \
    membackend/goblinHMCBackend.cc \
    membackend/hybridSimBackend.cc \
    membackend/vaultSimBackend.cc \
    membackend/pagedMultiBackend.cc \
    membackend/dramSimBackend.cc \
    membackend/cramSimBackend.cc \
    membackend/HBMpagedMultiBackend.cc \
    membackend/HBMdramSimBackend.cc \
    membackend/ramulatorBackend.cc \
    membackend/MessierBackend.cc \
    membackend/flashSimBackend.cc \
, $(SRC))
OBJ = $(SRCS:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all checkOptions install uninstall clean

merlin  ?= $(shell sst-config merlin  merlin_LIBDIR)
Messier ?= $(shell sst-config Messier Messier_LIBDIR)
CramSim ?= $(shell sst-config CramSim CramSim_LIBDIR)
ariel   ?= $(shell sst-config ariel   ariel_LIBDIR)
HMC     ?= $(shell sst-config HMC     HMC_LIBDIR)

all: checkOptions install

checkOptions:
ifneq ($(merlin),)
    INCLUDES  += -I$(merlin)
    LIBRARIES += -L$(merlin) -lmerlin
    SRCS += memNetBridge.cc
endif
ifneq ($(Messier),)
    INCLUDES  += -I$(Messier)
    LIBRARIES += -L$(Messier) -lMessier
    SRCS += membackend/MessierBackend.cc
endif
ifneq ($(CramSim),)
    INCLUDES  += -I$(CramSim)
    LIBRARIES += -L$(CramSim) -lCramSim
    SRCS += membackend/cramSimBackend.cc
endif
ifneq ($(ariel),)
    INCLUDES  += -I$(ariel)
    LIBRARIES += -L$(ariel) -lariel
    SRCS += Sieve/sieveController.cc Sieve/sieveFactory.cc Sieve/broadcastShim.cc Sieve/memmgr_sieve.cc
endif
ifneq ($(HMC),)
    INCLUDES  += -I$(HMC)
    LIBRARIES += -L$(HMC) -lHMC
    SRCS += membackend/goblinHMCBackend.cc
endif

ifdef DRAMSim
    INCLUDES  += -I$(DRAMSim)
    LIBRARIES += -L$(DRAMSim) -ldramsim
    $(shell sst-register DRAMSim DRAMSim_LIBDIR=$(DRAMSim))
    SRCS += membackend/pagedMultiBackend.cc membackend/dramSimBackend.cc
endif
ifdef HybridSim
    INCLUDES  += -I$(HybridSim)
    LIBRARIES += -L$(HybridSim) -lHybridSim
    SRCS += membackend/hybridSimBackend.cc
endif
ifdef VaultSimC
    INCLUDES  += -I$(VaultSimC)
    LIBRARIES += -L$(VaultSimC) -lVaultSimC
    SRCS += membackend/vaultSimBackend.cc
endif
ifdef HBMDRAMSim
    INCLUDES  += -I$(HBMDRAMSim)
    LIBRARIES += -L$(HBMDRAMSim) -lHBMDRAMSim
    SRCS += membackend/HBMpagedMultiBackend.cc membackend/HBMdramSimBackend.cc
endif
ifdef ramulator
    INCLUDES  += -I$(ramulator)
    LIBRARIES += -L$(ramulator) -lramulator
    SRCS += membackend/ramulatorBackend.cc
endif
ifdef flashSim
    INCLUDES  += -I$(flashSim)
    LIBRARIES += -L$(flashSim) -lflashSim
    SRCS += membackend/flashSimBackend.cc
endif

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -MMD -c $< -o $@

libmemHierarchy.so: $(OBJ)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(LDFLAGS) -o $@ $^ $(LIBRARIES)

install: libmemHierarchy.so
	sst-register memHierarchy memHierarchy_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u memHierarchy

clean: uninstall
	rm -rf .build libmemHierarchy.so
