#!/bin/bash

#######
#Change the below to reflect the website you are releasing your version of the dhmp pack for
#note the reverse order e.g. hiriwa.com = com.hiriwa
RELEASER="com.hiriwa"
#Do not change this license
LICENSE="Attribution-NonCommercial-ShareAlike 4.0 International https://creativecommons.org/licenses/by-nc-sa/4.0/"
#######
#the below tells the script what folders to look for packs in
FOLDERS_ARRAY=("ammunition" "artifact" "hud" "decorations" "keys" "monsters" "requires" "obstacles" "powerup" "weapons")
REQUIRES_ARRAY=("requires")
RECOMMENDS_ARRAY=("ammunition" "artifact" "hud" "decorations" "keys" "monsters" "obstacles" "powerup" "weapons")

#automaticly set variables
DATESTAMP=$(date +%Y%m%d)
SCRIPT_PATH=$(cd "$(dirname "$0")" ; pwd -P)
BASE_PATH=$(dirname "$SCRIPT_PATH")
echo $SCRIPT_PATH
echo $BASE_PATH

#functions
#function gather_requires {
#  requires=`ls requires | sed 's/.pack//g' | sed 's/ / com.hiriwa.dhmp./g'`
#}
function gather_packs() {
  RETURN_ARRAY=()
  dependency="$1_ARRAY[@]"
  for a in ${!dependency}
  do
    TEMP_ARRAY=(`ls $BASE_PATH/built/$PACK_FOLDERNAME/$a.pack`)
    for b in ${TEMP_ARRAY[@]}
    do
    sanitised=`echo "com.hiriwa.dhmp"$EXT"."$a.$b | sed 's/\.pack/,/g'`
    RETURN_ARRAY+=($sanitised)
#    RETURN_ARRAY+=("com.hiriwa.dhmp"$EXT"."$a.$b, )
    done
  done
  echo "<"${RETURN_ARRAY[@]}">"
}

function generate_info {
  echo "title: Doom High-res Model Project" >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  echo "version: "$DATESTAMP >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  echo "license: "$LICENSE >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  echo "tags: Doom 2 II tnt plutonia" >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  echo "notes = \"3D model replacements for Doom sprites\"" >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  echo "" >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  echo "" >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  dependency=$(gather_packs REQUIRES)
  echo "requires" $dependency >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  dependency=$(gather_packs RECOMMENDS) >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  echo "recommends" $dependency >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  dependency=$(gather_packs EXTRAS) >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  echo "extras" $dependency >> $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
  sed -i 's/,>/>/g' $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack/info.dei
}

#ask what texture resolution they want to build and ask to quit
while true
do
  read -p "Build with (S)src, (M)edium, or (L)ow resolution textures? (Q)uit" -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Mm]$ ]]
  then
    RESOLUTION="medium"
    EXT=""
    PACK_FOLDERNAME="$RELEASER.dhmp.pack"
    echo "$PACK_FOLDERNAME"
    break
  elif [[ $REPLY =~ ^[Ll]$ ]]
  then
    RESOLUTION="low"
    EXT=".low"
    PACK_FOLDERNAME="$RELEASER.dhmp.low.pack"
    echo "$PACK_FOLDERNAME"
    break
  elif [[ $REPLY =~ ^[Ss]$ ]]
  then
    RESOLUTION="src"
    EXT=".src"
    PACK_FOLDERNAME="$RELEASER.dhmp.src.pack"
    echo "$PACK_FOLDERNAME"
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
echo "$BASE_PATH/built/$PACK_FOLDERNAME"
mkdir -p $BASE_PATH/built/$PACK_FOLDERNAME
for PACK_TYPE in "${FOLDERS_ARRAY[@]}"
do   # The quotes are necessary here

  #create the packtype folder here and make sure the zip files go into it
  #e.g. obstacles.pack/
  PACK_TYPE_FOLDER=$PACK_TYPE.pack
  echo $PACK_TYPE_FOLDER
  mkdir -p $BASE_PATH/built/$PACK_FOLDERNAME/$PACK_TYPE_FOLDER

  pushd $BASE_PATH/$PACK_TYPE
  pwd
  PACKS=`ls`
  #for ever pack in the packs folder
  for PACK in $PACKS
  do
    echo "FOUND PACK"
    echo "$PACK"

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
      zip -r $BASE_PATH/built/$PACK_FOLDERNAME/$PACK_TYPE_FOLDER/$PACK *
#      zip -r $BASE_PATH/built/$PACK_FOLDERNAME/$RELEASER.dhmp.$PACK *
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
      fi
      pushd $BASE_PATH/doomsday/$PACK/
#      zip -r $BASE_PATH/built/$PACK_FOLDERNAME/$RELEASER.dhmp.low.$PACK *
      zip -r $BASE_PATH/built/$PACK_FOLDERNAME/$PACK_TYPE_FOLDER/$PACK *
      popd
    elif [[ "$RESOLUTION" == "src"  ]]
    #copy the pack to the build folder, delete the texture folders
    #we don't want and rename the one we do want to the right name
    then
      cp -R $PACK $BASE_PATH/doomsday/$PACK
      rm -r $BASE_PATH/doomsday/$PACK/textures-lowres
      rm -r $BASE_PATH/doomsday/$PACK/textures
      mv $BASE_PATH/doomsday/$PACK/textures-hires $BASE_PATH/doomsday/$PACK/textures
      BLEND_FILE=`ls $BASE_PATH/doomsday/$PACK | grep .blend`
      if [ ! -z "$BLEND_FILE" ]
      then
        echo "Removing unessesary blend file, we don't need to put it in a pack"
        rm -v $BASE_PATH/doomsday/$PACK/$BLEND_FILE
      else
        echo "No blend file found, therefore not trying to delete a blend file"
      fi
      pushd $BASE_PATH/doomsday/$PACK/
#      zip -r $BASE_PATH/built/$PACK_FOLDERNAME/$RELEASER.dhmp.low.$PACK *
      zip -r $BASE_PATH/built/$PACK_FOLDERNAME/$PACK_TYPE_FOLDER/$PACK *
      popd
    fi
  done
  popd
done
pushd $BASE_PATH/built/
#We need to add copywrite information into the pack,
cp $BASE_PATH/docs/* $BASE_PATH/built/$PACK_FOLDERNAME/
cp -R $BASE_PATH/dhmp $BASE_PATH/built/$PACK_FOLDERNAME/dhmp.pack
#generate the info.dei
generate_info
#compress the chosen pack
if [[ "$RESOLUTION" == "medium" ]]
then
  zip -r $BASE_PATH/built/$RELEASER.dhmp.$DATESTAMP.zip $PACK_FOLDERNAME
elif [[ "$RESOLUTION" == "low"  ]]
then
  zip -r $BASE_PATH/built/$RELEASER.dhmp.low.$DATESTAMP.zip $PACK_FOLDERNAME
elif [[ "$RESOLUTION" == "src"  ]]
then
  zip -r $BASE_PATH/built/$RELEASER.dhmp.src.$DATESTAMP.zip $PACK_FOLDERNAME
fi
echo "removing temporary build folder $PACK_FOLDERNAME so we don't taint the next build if filenames change"
rm -r $PACK_FOLDERNAME
popd
rm -r $BASE_PATH/doomsday
