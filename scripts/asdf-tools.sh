#!/bin/bash

TOOLS=$(cat $1)
for t in $TOOLS; do
	asdf plugin add $t
done
