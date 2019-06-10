#! /bin/bash

# redo memHierarchy at the end to compile some of the optional dependencies
elements=(\
    kingsley \
    scheduler \
    pyproto \
    shogun \
    merlin \
    CramSim \
    memHierarchy \
    Messier \
    cacheTracer \
    GNA \
    cassini \
    simpleElementExample \
    VaultSimC \
    miranda \
    thornhill \
    zodiac \
    memHierarchy \
)

for i in "${elements[@]}"; do
	cd $i
	echo -e "\033[1;4m${i}\033[0m"
	make "$@"
	echo
	cd ..
done
