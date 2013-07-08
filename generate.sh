#!/bin/bash
# Generate "derived data" using gzipped CHILDES XML files
# Kyle Gorman <gormanky@ohsu.edu>

# constants
CHI=./chi.py
MOT=./mot.py
SOURCE_DIR=XML
SOURCE_EXT=xml.gz
TARGET_DIR=derived
TARGET_EXT=csv

# check return codes
run_safe() {
   "$@" 2> /dev/null
   if [ $? != 0 ]; then
      echo "Error when executing command '$1'"
      exit $ERROR_CODE
   fi
}

echo -n "Processing individual children..."
# Abe
run_safe $CHI $SOURCE_DIR/US/Kuczaj/*.$SOURCE_EXT > $TARGET_DIR/Abe.$TARGET_EXT &
# Adam
run_safe $CHI $SOURCE_DIR/US/Brown/Adam/*.$SOURCE_EXT > $TARGET_DIR/Adam.$TARGET_EXT &
# Ella
run_safe $CHI $SOURCE_DIR/UK/Forrester/*.$SOURCE_EXT > $TARGET_DIR/Ella.$TARGET_EXT &
# Eve 
run_safe $CHI $SOURCE_DIR/US/Brown/Eve/*.$SOURCE_EXT > $TARGET_DIR/Eve.$TARGET_EXT &
# Lara
run_safe $CHI $SOURCE_DIR/UK/Lara/*.$SOURCE_EXT > $TARGET_DIR/Lara.$TARGET_EXT &
# Laura
run_safe $CHI $SOURCE_DIR/US/Braunwald/*.$SOURCE_EXT > $TARGET_DIR/Laura.$TARGET_EXT & 
# Naomi
run_safe $CHI $SOURCE_DIR/US/Sachs/*.$SOURCE_EXT > $TARGET_DIR/Naomi.$TARGET_EXT &
# Nathaniel
run_safe $CHI $SOURCE_DIR/US/Snow/*.$SOURCE_EXT > $TARGET_DIR/Nathaniel.$TARGET_EXT &
# Nina
run_safe $CHI $SOURCE_DIR/US/Suppes/*.$SOURCE_EXT > $TARGET_DIR/Nina.$TARGET_EXT &
# Peter
run_safe $CHI $SOURCE_DIR/US/Bloom70/Peter/*.$SOURCE_EXT > $TARGET_DIR/Peter.$TARGET_EXT &
# Sarah
run_safe $CHI $SOURCE_DIR/US/Brown/Sarah/*.$SOURCE_EXT > $TARGET_DIR/Sarah.$TARGET_EXT &
# Shem
run_safe $CHI $SOURCE_DIR/US/Clark/*.$SOURCE_EXT > $TARGET_DIR/Shem.$TARGET_EXT &
# Thomas
run_safe $CHI $SOURCE_DIR/UK/Thomas/*.$SOURCE_EXT > $TARGET_DIR/Thomas.$TARGET_EXT &
wait
echo "done."

echo -n "Processing whole corpora..."
# Bloom
run_safe $CHI $SOURCE_DIR/US/Bloom70/*/*.$SOURCE_EXT > $TARGET_DIR/Bloom70.$TARGET_EXT &
# Brown
run_safe $CHI $SOURCE_DIR/US/Brown/*/*.$SOURCE_EXT > $TARGET_DIR/Brown.$TARGET_EXT &
# Gleason
run_safe $CHI $SOURCE_DIR/US/Gleason/*/*.$SOURCE_EXT > $TARGET_DIR/Gleason.$TARGET_EXT &
# MacWhinney
run_safe $CHI $SOURCE_DIR/US/MacWhinney/*.$SOURCE_EXT > $TARGET_DIR/MacWhinney.$TARGET_EXT &
# Manchester
run_safe $CHI $SOURCE_DIR/UK/Manchester/*/*.$SOURCE_EXT > $TARGET_DIR/Manchester.$TARGET_EXT &
# New England
run_safe $CHI $SOURCE_DIR/US/NewEngland/*/*.$SOURCE_EXT > $TARGET_DIR/NewEngland.$TARGET_EXT &
# Post
run_safe $CHI $SOURCE_DIR/US/Post/*.$SOURCE_EXT > $TARGET_DIR/Post.$TARGET_EXT &
# Providence
run_safe $CHI $SOURCE_DIR/US/Providence/*/*.$SOURCE_EXT > $TARGET_DIR/Providence.$TARGET_EXT &
# Tardif
run_safe $CHI $SOURCE_DIR/US/Tardif/*.$SOURCE_EXT > $TARGET_DIR/Tardif.$TARGET_EXT &
# Wells
run_safe $CHI $SOURCE_DIR/UK/Wells/*.$SOURCE_EXT > $TARGET_DIR/Wells.$TARGET_EXT &
wait
echo "done."

echo -n "Processing combined corpora..."
# BK
run_safe $CHI $SOURCE_DIR/US/Brown/*/*.$SOURCE_EXT      \
              $SOURCE_DIR/US/Kuczaj/*.$SOURCE_EXT       \
              > $TARGET_DIR/BK.$TARGET_EXT &
# BKP
run_safe $CHI $SOURCE_DIR/US/Brown/*/*.$SOURCE_EXT      \
              $SOURCE_DIR/US/Kuczaj/*.$SOURCE_EXT       \
              $SOURCE_DIR/US/Providence/*/*.$SOURCE_EXT \
              > $TARGET_DIR/BKP.$TARGET_EXT &
# US
run_safe $CHI $SOURCE_DIR/US/Bloom70/*/*.$SOURCE_EXT    \
              $SOURCE_DIR/US/Braunwald/*.$SOURCE_EXT    \
              $SOURCE_DIR/US/Brown/*/*.$SOURCE_EXT      \
              $SOURCE_DIR/US/Clark/*.$SOURCE_EXT        \
              $SOURCE_DIR/US/Gleason/*/*.$SOURCE_EXT    \
              $SOURCE_DIR/US/Kuczaj/*.$SOURCE_EXT       \
              $SOURCE_DIR/US/Post/*.$SOURCE_EXT         \
              $SOURCE_DIR/US/Providence/*/*.$SOURCE_EXT \
              $SOURCE_DIR/US/Sachs/*.$SOURCE_EXT        \
              $SOURCE_DIR/US/Snow/*.$SOURCE_EXT         \
              $SOURCE_DIR/US/Suppes/*.$SOURCE_EXT       \
              $SOURCE_DIR/US/Tardif/*.$SOURCE_EXT       \
              > $TARGET_DIR/US.$TARGET_EXT &
# UK
run_safe $CHI $SOURCE_DIR/UK/Lara/*.$SOURCE_EXT         \
              $SOURCE_DIR/UK/Forrester/*.$SOURCE_EXT    \
              $SOURCE_DIR/UK/Manchester/*/*.$SOURCE_EXT \
              $SOURCE_DIR/UK/Thomas/*.$SOURCE_EXT       \
              $SOURCE_DIR/UK/Wells/*.$SOURCE_EXT        \
              > $TARGET_DIR/UK.$TARGET_EXT & 
# US-UK
run_safe $CHI $SOURCE_DIR/US/Bloom70/*/*.$SOURCE_EXT    \
              $SOURCE_DIR/US/Braunwald/*.$SOURCE_EXT    \
              $SOURCE_DIR/US/Brown/*/*.$SOURCE_EXT      \
              $SOURCE_DIR/US/Clark/*.$SOURCE_EXT        \
              $SOURCE_DIR/UK/Forrester/*.$SOURCE_EXT    \
              $SOURCE_DIR/US/Gleason/*/*.$SOURCE_EXT    \
              $SOURCE_DIR/US/Kuczaj/*.$SOURCE_EXT       \
              $SOURCE_DIR/UK/Lara/*.$SOURCE_EXT         \
              $SOURCE_DIR/UK/Manchester/*/*.$SOURCE_EXT \
              $SOURCE_DIR/US/Post/*.$SOURCE_EXT         \
              $SOURCE_DIR/US/Providence/*/*.$SOURCE_EXT \
              $SOURCE_DIR/US/Sachs/*.$SOURCE_EXT        \
              $SOURCE_DIR/US/Snow/*.$SOURCE_EXT         \
              $SOURCE_DIR/US/Suppes/*.$SOURCE_EXT       \
              $SOURCE_DIR/US/Tardif/*.$SOURCE_EXT       \
              $SOURCE_DIR/UK/Thomas/*.$SOURCE_EXT       \
              $SOURCE_DIR/UK/Wells/*.$SOURCE_EXT        \
              > $TARGET_DIR/US-UK.$TARGET_EXT &
wait
echo "done."

echo -n "Processing child-directed speech corpora..."
# Brent
run_safe $MOT $SOURCE_DIR/US/Brent/*/*.$SOURCE_EXT > $TARGET_DIR/Brent-CDS.$TARGET_EXT &
# Brown
run_safe $MOT $SOURCE_DIR/US/Brown/*/*.$SOURCE_EXT > $TARGET_DIR/Brown-CDS.$TARGET_EXT &
# Gleason
run_safe $MOT $SOURCE_DIR/US/Gleason/*/*.$SOURCE_EXT > $TARGET_DIR/Gleason-CDS.$TARGET_EXT &
# New England
run_safe $MOT $SOURCE_DIR/US/NewEngland/*/*.$SOURCE_EXT > $TARGET_DIR/NewEngland-CDS.$TARGET_EXT &
# Providence
run_safe $MOT $SOURCE_DIR/US/Providence/*/*.$SOURCE_EXT > $TARGET_DIR/Providence-CDS.$TARGET_EXT &
# Snow
run_safe $MOT $SOURCE_DIR/US/Snow/*.$SOURCE_EXT > $TARGET_DIR/Nathaniel-CDS.$TARGET_EXT &
# Suppes
run_safe $MOT $SOURCE_DIR/US/Suppes/*.$SOURCE_EXT > $TARGET_DIR/Nina.$TARGET_EXT &
# Tardif
run_safe $MOT $SOURCE_DIR/US/Tardif/*.$SOURCE_EXT > $TARGET_DIR/Tardif.$TARGET_EXT &
# Global CDS
run_safe $MOT $SOURCE_DIR/US/Brent/*/*.$SOURCE_EXT      \
              $SOURCE_DIR/US/Brown/*/*.$SOURCE_EXT      \
              $SOURCE_DIR/US/Gleason/*/*.$SOURCE_EXT    \
              $SOURCE_DIR/US/NewEngland/*/*.$SOURCE_EXT \
              $SOURCE_DIR/US/Providence/*/*.$SOURCE_EXT \
              $SOURCE_DIR/US/Snow/*.$SOURCE_EXT         \
              $SOURCE_DIR/US/Suppes/*.$SOURCE_EXT       \
              $SOURCE_DIR/US/Tardif/*.$SOURCE_EXT       \
              > $TARGET_DIR/CDS.$TARGET_EXT &
wait
echo "done."
