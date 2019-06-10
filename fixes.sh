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
	# Grab the element to help parse things out
	element=$(echo $f | cut -d'/' -f2)
	
	# search for either <sst_config.h> or "sst_config.h" and replace with <sst/core/sst_config.h>
	# delete sst/elements/*/ and sst/elements/
	sed -i -e 's|<sst_config\.h>|<sst/core/sst_config.h>|g
	           s|"sst_config\.h"|<sst/core/sst_config.h>|g
	           s|sst/elements/.*/||g
	           s|sst/elements/||g' $f

	# search for either <output.h> or "output.h" and replace with <sst/core/output.h> except in scheduler
	if [ "$element" != "scheduler" ]; then
		sed -i -e 's|<output\.h>|<sst/core/output.h>|g
	             s|"output\.h"|<sst/core/output.h>|g' $f
	fi
done
