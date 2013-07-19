#!/bin/bash
# generate.sh: make "derived data" from gzipped CHILDES XML files
# Kyle Gorman <gormanky@ohsu.edu>

# constants
CHI=./chi.py
SOURCE_DIR=../XML
SOURCE_EXT=xml.gz
TARGET_DIR=../derived
TARGET_EXT=csv

$CHI $SOURCE_DIR/UK/Thomas/*.$SOURCE_EXT > $TARGET_DIR/Thomas.$TARGET_EXT

if [ $? != 0 ]; then
    echo "Error in processing.";
fi
