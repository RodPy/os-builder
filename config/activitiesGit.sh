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

#- 10 -
# KukuAnakula Activity
#git clone git://git.sugarlabs.org/kukuanakula/mainline.git

