#!/bin/bash
# generate.sh: make "derived data" from gzipped CHILDES XML files
# Kyle Gorman <gormanky@ohsu.edu>

# constants
CHI=./chi.py
SOURCE_DIR=../XML
SOURCE_EXT=xml.gz
TARGET_DIR=../derived
TARGET_EXT=csv

$CHI $SOURCE_DIR/US/Bloom70_Peter/*.$SOURCE_EXT   \
     $SOURCE_DIR/US/Braunwald_Laura/*.$SOURCE_EXT \
     $SOURCE_DIR/US/Brown_*/*.$SOURCE_EXT         \
     $SOURCE_DIR/US/Clark_Shem/*.$SOURCE_EXT      \
     $SOURCE_DIR/US/Demetras_Trevor/*.$SOURCE_EXT \
     $SOURCE_DIR/US/Feldman_Steven/*.$SOURCE_EXT  \
     $SOURCE_DIR/US/Kuczaj_Abe/*.$SOURCE_EXT      \
     $SOURCE_DIR/US/MacWhinney/*.$SOURCE_EXT      \
     $SOURCE_DIR/US/Providence_*/*.$SOURCE_EXT    \
     $SOURCE_DIR/US/Sachs_Naomi/*.$SOURCE_EXT     \
     $SOURCE_DIR/US/Snow_Nathaniel/*.$SOURCE_EXT  \
     $SOURCE_DIR/US/Suppes_Nina/*.$SOURCE_EXT     \
     $SOURCE_DIR/UK/Cruttenden_*/*.$SOURCE_EXT    \
     $SOURCE_DIR/UK/Lara/*.$SOURCE_EXT            \
     $SOURCE_DIR/UK/Manchester_*/*.$SOURCE_EXT    \
     $SOURCE_DIR/UK/Thomas/*.$SOURCE_EXT          \
     > $TARGET_DIR/UK-US.$TARGET_EXT
     #$SOURCE_DIR/US/Peters_Seth/*.$SOURCE_EXT     \
     #$SOURCE_DIR/UK/Wells_*/*.$SOURCE_EXT         \

if [ $? != 0 ]; then
    echo "Error during execution"
    exit $?
fi
