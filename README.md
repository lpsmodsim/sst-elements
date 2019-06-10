List of elements that have been separated and run standalone:

kingsley
scheduler
pyproto - builds but python can't find sst.pyproto (doesn't work for combined sst-elements either)

merlin
CramSim - TxnDispatcher.cpp is messed up, compiles without that

memHierarchy - not completely tested, DRAMSim appears to work - optional dependency on merlin, Messier, CramSim
Messier - depends on memHierarchy
cacheTracer - depends on memHierarchy
GNA - depends on memHierarchy
cassini - dmaengine.cc is messed up, compiles without that - depends on memHierarchy
simpleElementExample - simpleTracerComponent.cc is messed up, compiles without that - depends on memHierarchy
VaultSimC - depends on memHierarchy

Opal - depends on memHierarchy
Samba - depends on memHierarchy, Opal


miranda - haven't tested stake
thornhill - depends on miranda
hermes  - merged into thornhill
firefly - nicTester.cc is messed up, compiles without that - depends on thornhill
zodiac - need to test dumpi and otf - depends on thornhill
ember - tools compiled separately? need to test, emberotf2.cc needs otf? - depends on thornhill



Ignoring:
ariel - PIN
prospero - PIN
SysC - bad
HMC - uses systemc
savannah - no code........
vanadis - no code again?!?!?
simpleSimulation - this is the old version of the carwash





thornhill & hermes - no tests

Tested and Runs:
cacheTracer
cassini
GNA
kingsley
Messier
miranda - skipped goblin HMC tests, others seem to work
VaultSimC - skipped pim test, sdl tests work
simpleElementExample - Tracer component doesn't work, everything else does



Tested and Problems:
CramSim - several values are missing, could be config file? Does run without crashing
ember - refers to old naming for merlin topos
firefly - no python tests, guessing that nicTester is the test
merlin - changed naming, torus still doesn't work
Opal - uses ariel for test
Samba - Opal test does a divide by 0 error
scheduler - no python tests? yumyum perl script has hardcoded sst-core location
zodiac - no python tests?

