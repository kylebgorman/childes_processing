#!/bin/bash
# generate.sh: make "derived data" from gzipped CHILDES XML files
# Kyle Gorman <gormanky@ohsu.edu>

# constants
CHI=./chi.py
MOT=./mot.py
SOURCE_DIR=../XML
SOURCE_EXT=xml.gz
TARGET_DIR=../derived
TARGET_EXT=csv

# check return codes
run_safe() {
   "$@"
   if [ $? != 0 ]; then
      echo "Error when executing command '$1'"
      exit $ERROR_CODE
   fi
}

echo -n "Processing individual children..."
# US
run_safe $CHI $SOURCE_DIR/US/Bloom70_Peter/*.$SOURCE_EXT > $TARGET_DIR/Peter.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Braunwald_Laura/*.$SOURCE_EXT > $TARGET_DIR/Laura.$TARGET_EXT & 
run_safe $CHI $SOURCE_DIR/US/Brown_Adam/*.$SOURCE_EXT > $TARGET_DIR/Adam.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Brown_Sarah/*.$SOURCE_EXT > $TARGET_DIR/Sarah.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Brown_Eve/*.$SOURCE_EXT > $TARGET_DIR/Eve.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Clark_Shem/*.$SOURCE_EXT > $TARGET_DIR/Shem.$TARGET_EXT &
##FIXME Davis?
#run_safe $CHI $SOURCE_DIR/US/Davis_Aaron/*.$SOURCE_EXT > $TARGET_DIR/Aaron.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Ben/*.$SOURCE_EXT > $TARGET_DIR/Ben.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Cameron/*.$SOURCE_EXT > $TARGET_DIR/Cameron.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Charlotte/*.$SOURCE_EXT > $TARGET_DIR/Charlotte.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Georgia/*.$SOURCE_EXT > $TARGET_DIR/Georgia.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Hannah/*.$SOURCE_EXT > $TARGET_DIR/Hannah.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Jodie/*.$SOURCE_EXT > $TARGET_DIR/Jodie.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Kaeley/*.$SOURCE_EXT > $TARGET_DIR/Kaeley.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Kate/*.$SOURCE_EXT > $TARGET_DIR/Kate.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Martin/*.$SOURCE_EXT > $TARGET_DIR/MartinD.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Micah/*.$SOURCE_EXT > $TARGET_DIR/Micah.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Nate/*.$SOURCE_EXT > $TARGET_DIR/Nate.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Nick/*.$SOURCE_EXT > $TARGET_DIR/Nick.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Paxton/*.$SOURCE_EXT > $TARGET_DIR/Paxtoin.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Rebecca/*.$SOURCE_EXT > $TARGET_DIR/Rebecca.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Rowan/*.$SOURCE_EXT > $TARGET_DIR/Rowan.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Sadie/*.$SOURCE_EXT > $TARGET_DIR/Sadie.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Sam/*.$SOURCE_EXT > $TARGET_DIR/Sam.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/US/Davis_Willie/*.$SOURCE_EXT > $TARGET_DIR/Willie.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Demetras_Trevor/*.$SOURCE_EXT > $TARGET_DIR/Trevor.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Feldman_Steven/*.$SOURCE_EXT > $TARGET_DIR/Steven.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Kuczaj_Abe/*.$SOURCE_EXT > $TARGET_DIR/Abe.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Nelson_Emily/*.$SOURCE_EXT > $TARGET_DIR/Emily.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Providence_Alex/*.$SOURCE_EXT > $TARGET_DIR/Alex.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Providence_Ethan/*.$SOURCE_EXT > $TARGET_DIR/Alex.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Providence_Lily/*.$SOURCE_EXT > $TARGET_DIR/Lily.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Providence_Naima/*.$SOURCE_EXT > $TARGET_DIR/Naima.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Providence_Violet/*.$SOURCE_EXT > $TARGET_DIR/Violet.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Providence_William/*.$SOURCE_EXT > $TARGET_DIR/William.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Peters_Seth/*.$SOURCE_EXT > $TARGET_DIR/Seth.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Sachs_Naomi/*.$SOURCE_EXT > $TARGET_DIR/Naomi.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Snow_Nathaniel/*.$SOURCE_EXT > $TARGET_DIR/Nathaniel.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Suppes_Nina/*.$SOURCE_EXT > $TARGET_DIR/Nina.$TARGET_EXT &
# UK (less useful: Ella, Jane, Lucy)
run_safe $CHI $SOURCE_DIR/UK/Cruttenden_Jane/*.$SOURCE_EXT > $TARGET_DIR/Jane.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Cruttenden_Lucy/*.$SOURCE_EXT > $TARGET_DIR/Lucy.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Forrester_Ella/*.$SOURCE_EXT > $TARGET_DIR/Ella.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Lara/*.$SOURCE_EXT > $TARGET_DIR/Lara.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Anne/*.$SOURCE_EXT > $TARGET_DIR/Anne.$TARGET_EXT & 
run_safe $CHI $SOURCE_DIR/UK/Manchester_Aran/*.$SOURCE_EXT > $TARGET_DIR/Aran.$TARGET_EXT & 
run_safe $CHI $SOURCE_DIR/UK/Manchester_Becky/*.$SOURCE_EXT > $TARGET_DIR/Becky.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Carl/*.$SOURCE_EXT > $TARGET_DIR/Carl.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Dominic/*.$SOURCE_EXT > $TARGET_DIR/Dominic.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Gail/*.$SOURCE_EXT > $TARGET_DIR/Gail.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Joel/*.$SOURCE_EXT > $TARGET_DIR/Joel.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_John/*.$SOURCE_EXT > $TARGET_DIR/John.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Liz/*.$SOURCE_EXT > $TARGET_DIR/Liz.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Nicole/*.$SOURCE_EXT > $TARGET_DIR/Nicole.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Ruth/*.$SOURCE_EXT > $TARGET_DIR/Ruth.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Manchester_Warren/*.$SOURCE_EXT > $TARGET_DIR/Warren.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Thomas/*.$SOURCE_EXT > $TARGET_DIR/Thomas.$TARGET_EXT &
##FIXME Wells?
#run_safe $CHI $SOURCE_DIR/UK/Wells_Abigail/*.$SOURCE_EXT > $TARGET_DIR/Abigail.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Benjamin/*.$SOURCE_EXT > $TARGET_DIR/Benjamin.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Betty/*.$SOURCE_EXT > $TARGET_DIR/Betty.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Darren/*.$SOURCE_EXT > $TARGET_DIR/Darren.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Debbie/*.$SOURCE_EXT > $TARGET_DIR/Debbie.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Ellen/*.$SOURCE_EXT > $TARGET_DIR/Ellen.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Elspeth/*.$SOURCE_EXT > $TARGET_DIR/Elspeth.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Frances/*.$SOURCE_EXT > $TARGET_DIR/Frances.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Gary/*.$SOURCE_EXT > $TARGET_DIR/Gary.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Gavin/*.$SOURCE_EXT > $TARGET_DIR/Gavin.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Geoffrey/*.$SOURCE_EXT > $TARGET_DIR/Geoffrey.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Gerald/*.$SOURCE_EXT > $TARGET_DIR/Gerald.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Harriet/*.$SOURCE_EXT > $TARGET_DIR/Harriet.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Iris/*.$SOURCE_EXT > $TARGET_DIR/Iris.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Jack/*.$SOURCE_EXT > $TARGET_DIR/Jack.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Jason/*.$SOURCE_EXT > $TARGET_DIR/Jason.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Jonathan/*.$SOURCE_EXT > $TARGET_DIR/Jonathan.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Laura/*.$SOURCE_EXT > $TARGET_DIR/LauraW.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Lee/*.$SOURCE_EXT > $TARGET_DIR/Lee.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Martin/*.$SOURCE_EXT > $TARGET_DIR/Martin.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Nancy/*.$SOURCE_EXT > $TARGET_DIR/Nancy.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Neil/*.$SOURCE_EXT > $TARGET_DIR/Neil.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Neville/*.$SOURCE_EXT > $TARGET_DIR/Neville.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Olivia/*.$SOURCE_EXT > $TARGET_DIR/Olivia.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Penny/*.$SOURCE_EXT > $TARGET_DIR/Penny.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Rosie/*.$SOURCE_EXT > $TARGET_DIR/Rosie.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Samantha/*.$SOURCE_EXT > $TARGET_DIR/Samantha.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Sean/*.$SOURCE_EXT > $TARGET_DIR/Sean.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Sheila/*.$SOURCE_EXT > $TARGET_DIR/Sheila.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Simon/*.$SOURCE_EXT > $TARGET_DIR/Simon.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Stella/*.$SOURCE_EXT > $TARGET_DIR/Stella.$TARGET_EXT &
#run_safe $CHI $SOURCE_DIR/UK/Wells_Tony/*.$SOURCE_EXT > $TARGET_DIR/Tony.$TARGET_EXT &
wait
echo "done."

echo -n "Processing whole corpora..."
# US
# FIXME Davis? Post?
run_safe $CHI $SOURCE_DIR/US/Brown_*/*.$SOURCE_EXT > $TARGET_DIR/Brown.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/UK/Cruttenden_*/*.$SOURCE_EXT > $TARGET_DIR/Cruttenden.$TARGET_EXT &
# MacWhinney goofiness
run_safe $CHI $SOURCE_DIR/US/MacWhinney/*.$SOURCE_EXT > $TARGET_DIR/MacWhinney.$TARGET_EXT &
wait;
run_safe head -1 $TARGET_DIR/MacWhinney.$TARGET_EXT > $TARGET_DIR/Mark.$TARGET_EXT
run_safe head -1 $TARGET_DIR/MacWhinney.$TARGET_EXT > $TARGET_DIR/Ross.$TARGET_EXT
run_safe grep ',"Mark",' $TARGET_DIR/MacWhinney.$TARGET_EXT >> $TARGET_DIR/Mark.$TARGET_EXT & 
run_safe grep ',"Ross",' $TARGET_DIR/MacWhinney.$TARGET_EXT >> $TARGET_DIR/Ross.$TARGET_EXT & 
# /MacWhinney goofiness
run_safe $CHI $SOURCE_DIR/UK/Manchester_*/*.$SOURCE_EXT > $TARGET_DIR/Manchester.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Post/*.$SOURCE_EXT > $TARGET_DIR/Post.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Providence_*/*.$SOURCE_EXT > $TARGET_DIR/Providence.$TARGET_EXT &
# Wells
run_safe $CHI $SOURCE_DIR/UK/Wells_*/*.$SOURCE_EXT > $TARGET_DIR/Wells.$TARGET_EXT &
wait
echo "done."

echo -n "Processing combined corpora..."
run_safe $CHI $SOURCE_DIR/US/Brown_*/*.$SOURCE_EXT      \
              $SOURCE_DIR/US/Kuczaj_Abe/*.$SOURCE_EXT   \
              > $TARGET_DIR/BK.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Brown_*/*.$SOURCE_EXT      \
              $SOURCE_DIR/US/Kuczaj_Abe/*.$SOURCE_EXT   \
              $SOURCE_DIR/US/Providence_*/*.$SOURCE_EXT \
              > $TARGET_DIR/BKP.$TARGET_EXT &
run_safe $CHI $SOURCE_DIR/US/Bloom70_Peter/*.$SOURCE_EXT   \
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
              > $TARGET_DIR/US.$TARGET_EXT &
              #FIXME
              #$SOURCE_DIR/US/Nelson_Emily/*.$SOURCE_EXT    \
              #$SOURCE_DIR/US/Peters_Seth/*.$SOURCE_EXT     \
run_safe $CHI $SOURCE_DIR/UK/Cruttenden_*/*.$SOURCE_EXT \
              $SOURCE_DIR/UK/Lara/*.$SOURCE_EXT         \
              $SOURCE_DIR/UK/Manchester_*/*.$SOURCE_EXT \
              $SOURCE_DIR/UK/Thomas/*.$SOURCE_EXT       \
              > $TARGET_DIR/UK.$TARGET_EXT & 
              #FIXME
              #$SOURCE_DIR/UK/Wells_*/*.$SOURCE_EXT      \
run_safe $CHI $SOURCE_DIR/US/Bloom70_Peter/*.$SOURCE_EXT   \
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
              > $TARGET_DIR/UK-US.$TARGET_EXT &
              #FIXME
              #$SOURCE_DIR/US/Nelson_Emily/*.$SOURCE_EXT    \
              #$SOURCE_DIR/US/Peters_Seth/*.$SOURCE_EXT     \
              #$SOURCE_DIR/UK/Wells_*/*.$SOURCE_EXT         \
wait
echo "done."

echo -n "Processing child-directed speech corpora..."
run_safe $MOT $SOURCE_DIR/US/Brent_*/*.$SOURCE_EXT > $TARGET_DIR/Brent-CDS.$TARGET_EXT &
run_safe $MOT $SOURCE_DIR/US/Brown_*/*.$SOURCE_EXT > $TARGET_DIR/Brown-CDS.$TARGET_EXT &
run_safe $MOT $SOURCE_DIR/US/NewEngland_32/*.$SOURCE_EXT > $TARGET_DIR/NewEngland-CDS.$TARGET_EXT &
run_safe $MOT $SOURCE_DIR/US/Providence_*/*.$SOURCE_EXT > $TARGET_DIR/Providence-CDS.$TARGET_EXT &
run_safe $MOT $SOURCE_DIR/US/Snow_Nathaniel/*.$SOURCE_EXT > $TARGET_DIR/Nathaniel-CDS.$TARGET_EXT &
run_safe $MOT $SOURCE_DIR/US/Suppes_Nina/*.$SOURCE_EXT > $TARGET_DIR/Nina-CDS.$TARGET_EXT &
run_safe $MOT $SOURCE_DIR/US/Brent_*/*.$SOURCE_EXT        \
              $SOURCE_DIR/US/Brown_*/*.$SOURCE_EXT        \
              $SOURCE_DIR/US/NewEngland_32/*.$SOURCE_EXT  \
              $SOURCE_DIR/US/Providence_*/*.$SOURCE_EXT   \
              $SOURCE_DIR/US/Snow_Nathaniel/*.$SOURCE_EXT \
              $SOURCE_DIR/US/Suppes_Nina/*.$SOURCE_EXT    \
              > $TARGET_DIR/CDS.$TARGET_EXT &
wait
echo "done."
