#!/bin/bash

#####################################
#CONFIGURATION                      #
#####################################

projectName='My Change Log'
formatCommit='%H%x09%s'
changeLogFile='change.log'

#####################################

#####################################
#CODE                               #
#####################################

>${changeLogFile}

echo ${projectName}>>${changeLogFile}
echo created: `date`>>${changeLogFile}
echo =====================================>>${changeLogFile}
echo >>${changeLogFile}

storeIfs=IFS
IFS=$'\n'

# mac command
#git_tag=`git tag -l | gsort -V`

# linux command
#git_tag=`git tag -l | sort -V`

# git 2.2 and above
git_tag=`git tag --sort -version:refname`

set -- $git_tag
tags=( $@ )

clean_tags_from_test_tags=()
clean_tags_from_test_tags_commits=()
index=0
for tag in ${tags[@]};
do
    commit_hash=`git rev-list -n 1 $tag`
    clean_tags_from_test_tags[ ${index} ]=$tag
    clean_tags_from_test_tags_commits[ ${index} ]=$commit_hash
    echo -e "found tag\t${tag} ($index) with hash\t\t$commit_hash"
    ((index++))
done

count=${index}
((count--))

# build log
index=0
for tag in ${clean_tags_from_test_tags[@]};
do
    echo $tag>>${changeLogFile}
    echo '--------'>>${changeLogFile}
    echo>>${changeLogFile}
    echo>>${changeLogFile}

    if [[ ${index} -lt ${count} ]] ;
    then
        commits=`git log --pretty=format:"${formatCommit}" --full-index ${clean_tags_from_test_tags_commits[$index + 1]}..${clean_tags_from_test_tags_commits[$index]}`
    else
        commits=`git log --pretty=format:"${formatCommit}" --full-index ${clean_tags_from_test_tags_commits[$index]}`
    fi

    set -- $commits
    commitsArray=( $@ )

    for commit in ${commitsArray[@]};
    do
        echo -e '\t' $commit>>${changeLogFile}
    done

    echo>>${changeLogFile}
    echo>>${changeLogFile}
    echo>>${changeLogFile}

    ((index++))
done

IFS=${storeIfs}

#####################################
