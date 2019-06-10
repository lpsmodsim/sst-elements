#!/bin/bash

# This file contains the changes needed to quickly swap the elements over to standalone versions

CFILES=$(find . -name '*.c')
HFILES=$(find . -name '*.h')
CCFILES=$(find . -name '*.cc')
CPPFILES=$(find . -name '*.cpp')
HPPFILES=$(find . -name '*.hpp')

PYTHONFILES=$(find . -name '*.py')

CXXFILES="$CFILES $HFILES $CCFILES $CPPFILES $HPPFILES"

for f in $CXXFILES; do
	# On mac sed -i needs '' as the extension, should check for this
	
	# search for either <sst_config.h> or "sst_config.h" and replace with <sst/core/sst_config.h>
	# delete sst/elements
	sed -i 's|.sst_config\.h.|<sst/core/sst_config.h>|g; s|sst/elements/||g' $f
done
