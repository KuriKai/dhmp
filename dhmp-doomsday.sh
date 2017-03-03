#!/bin/bash

datestamp=$(date +%Y%m%d)
SCRIPT_PATH=$(cd "$(dirname "$0")" ; pwd -P)
BASE_PATH=$SCRIPT_PATH
BUILDING_PATH=$BASE_PATH/doomsday

FOLDERS_ARRAY=("ammunition" "artifact" "decorations" "keys" "monsters" "obstacles" "other" "powerup" "weapons")


echo "rm -r $BASE_PATH/doomsday"
echo ---------starting to create the DHMP for the doomsday engine and compatible engines---------
echo "mkdir $BASE_PATH/doomsday"
echo "mkdir $BASE_PATH/built"


for PACK_TYPE in "${FOLDERS_ARRAY[@]}"
do   # The quotes are necessary here
  pushd $PACK_TYPE
  PACKS=`ls`
  for PACK in $PACKS
  do
    echo "FOUND PACK"
    echo "$PACK"
    #We need to add copywrite information into the pack, 
    #and choose which resolution of textures to go in
    zip -r $BUILDING_PATH/dhmp.$PACK $PACK
  done
  popd
done
#select resolution

#for each modelPack in objectType
#copy to temp folder along with selected resolution texturesFolder
#then archive in zip file
#then move zip file to a "built" folder and get rid of the zip extension

echo "rm -r $BASE_PATH/doomsday"
