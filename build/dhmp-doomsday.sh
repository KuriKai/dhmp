#!/bin/bash

DATESTAMP=$(date +%Y%m%d)
SCRIPT_PATH=$(cd "$(dirname "$0")" ; pwd -P)
BASE_PATH=$(dirname "$SCRIPT_PATH")
echo $SCRIPT_PATH
echo $BASE_PATH

FOLDERS_ARRAY=("ammunition" "artifact" "decorations" "keys" "monsters" "obstacles" "other" "powerup" "weapons")

#ask what texture resolution they want to build and ask to quit
while true
do
  read -p "Build with (M)edium or (L)ow resolution textures? (Q)uit" -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Mm]$ ]]
  then
    RESOLUTION="medium"
    break
  elif [[ $REPLY =~ ^[Ll]$ ]]
  then
    RESOLUTION="low"
    break
  elif [[  $REPLY =~ ^[Qq]$  ]]
  then
    exit 0
  fi
done

#start the building of the packs
rm -r $BASE_PATH/doomsday
echo ---------starting to create the DHMP for the doomsday engine and compatible engines---------
mkdir $BASE_PATH/doomsday
mkdir $BASE_PATH/built

for PACK_TYPE in "${FOLDERS_ARRAY[@]}"
do   # The quotes are necessary here
  pushd $BASE_PATH/$PACK_TYPE
  pwd
  PACKS=`ls`
  for PACK in $PACKS
  do
    echo "FOUND PACK"
    echo "$PACK"
    #We need to add copywrite information into the pack,
    if [[ "$RESOLUTION" == "medium" ]]
    #copy the pack to the build folder, delete the texture folders
    #we don't want
    then
      cp -R $PACK $BASE_PATH/doomsday/$PACK
      rm -r $BASE_PATH/doomsday/$PACK/textures-hires
      rm -r $BASE_PATH/doomsday/$PACK/textures-lowres
      BLEND_FILE=`ls $BASE_PATH/doomsday/$PACK | grep .blend`
      if [ ! -z "$BLEND_FILE" ]
      then
        echo "Removing unessesary blend file, we don't need to put it in a pack"
        rm -v $BASE_PATH/doomsday/$PACK/$BLEND_FILE
      else
        echo "No blend file found, therefore not trying to delete a blend file"
      fi
      pushd $BASE_PATH/doomsday/$PACK/
      zip -r $BASE_PATH/built/dhmp.$PACK *
      popd
    elif [[ "$RESOLUTION" == "low"  ]]
    #copy the pack to the build folder, delete the texture folders
    #we don't want and rename the one we do want to the right name
    then
      cp -R $PACK $BASE_PATH/doomsday/$PACK
      rm -r $BASE_PATH/doomsday/$PACK/textures-hires
      rm -r $BASE_PATH/doomsday/$PACK/textures
      mv $BASE_PATH/doomsday/$PACK/textures-lowres $BASE_PATH/doomsday/$PACK/textures
      BLEND_FILE=`ls $BASE_PATH/doomsday/$PACK | grep .blend`
      if [ ! -z "$BLEND_FILE" ]
      then
        echo "Removing unessesary blend file, we don't need to put it in a pack"
        rm -v $BASE_PATH/doomsday/$PACK/$BLEND_FILE
      else
        echo "No blend file found, therefore not trying to delete a blend file"
      fi      pushd $BASE_PATH/doomsday/$PACK/
      zip -r $BASE_PATH/built/dhmp.low.$PACK *
      popd
    fi
  done
  popd
done

rm -r $BASE_PATH/doomsday
