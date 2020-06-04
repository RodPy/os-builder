# ! /bin/bash root

for k in $(jq '.repository | keys | .[]' repository.json); do
    value=$(jq -r ".repository[$k]" repository.json)
    repositoryName=$(jq -r '.name' <<<"$value")
    link=$(jq -r '.link' <<<"$value")
    flagVersion=$(jq -r 'if .version == "" then 0 else 1 end' <<<"$value")
    echo $flagVersion
    echo $repositoryName
    echo $link
    if [ $flagVersion == 0 ]; then
        commit=$(jq -r '.last_commit' <<<"$value")
        echo $commit
        git clone $link
        cd $repositoryName
        git checkout $commit
        cd ..
    else
        version=$(jq -r '.version' <<<"$value")
        echo $link
        git clone -b $version $link
    fi
done

#GIT
#- 1 -
# Diccionary ESP-GUA Artivity
git clone https://github.com/sugarlabs/diccionario-guarani-castellano-activity.git

#- 2 -
# Help Artivity
git clone -b v20 https://github.com/sugarlabs/help-activity.git

#- 3 -
# Letter Matchs Activity
git clone -b v9 https://github.com/sugarlabs/lettermatch.git

#- 4 -
# TuxPaint
git clone https://github.com/sugarlabs/tuxpaint-wrapper-activity.git

#- 5 -
# Turtle Typing Activity
git clone -b v32 https://github.com/sugarlabs/typing-turtle-activity.git

#- 7 -
# xoeditor Artivity
git clone -b v14 https://github.com/sugarlabs/xoeditor-activity.git

#GTK2
#-  1 -
# Derecho a Transitar Artivity
git clone https://github.com/sugarlabs/derecho-a-transitar-activity.git

#- 2 -
# I can read Artivity
git clone https://github.com/sugarlabs/i-can-read-activity.git

#- 3 -
# Jam Media explorer Artivity
git clone https://github.com/sugarlabs/jam-media-explorer-activity.git

#- 4 -
# KukuAnakula Activity
git clone git://git.sugarlabs.org/kukuanakula/mainline.git

#- 5 -
# labyrinth-activity (mapMent)
git clone https://github.com/sugarlabs/labyrinth-activity.git

#- 6 -
# Rompecabezas Activity
git clone -b v11 https://github.com/sugarlabs/jigsaw-puzzle-branch.git

#GTK3
#- 1 -
# Get Books Artivity
git clone -b v19 https://github.com/sugarlabs/get-books-activity.git

#- 2 -
# Turtle confusion Activity
git clone https://github.com/sugarlabs/activity-turtle-confusion.git

#-   1 -
# Turtle Art Artivity
git clone -b v220 https://github.com/sugarlabs/turtleart-activity.git

#- -
#Jclic  Activity
git clone -b v1 https://github.com/sugarlabs/JClic.git

#-  -
#Java  Activity
git clone https://github.com/sugarlabs/Java.git

#Etoys  Activity
git clone https://github.com/ParaguayEduca/etoys.activity.git

#-  -
#GCompris  Activity
git clone https://github.com/ParaguayEduca/gcompris-activity.git

#-  -
#Geogebra.  Activity
git clone https://github.com/ParaguayEduca/geogebra-activity.git

#-  -
#Scratch  Activity
git clone https://github.com/ParaguayEduca/scratch-activity.git
