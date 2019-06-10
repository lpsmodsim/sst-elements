#! /bin/bash

elements=(\
    kingsley \
    scheduler \
    pyproto \
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
    memHierarchy \ # redo memHierarchy at the end to compile some of the optional dependencies
)

for i in "${elements[@]}"; do
	cd $i
	echo -e "\033[1;4m${i}\033[0m"
	make "$@"
	echo
	cd ..
done
