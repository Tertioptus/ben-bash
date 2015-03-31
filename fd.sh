#!/bin/bash

args=("$@")
DIRS=()
FILTER=".*${args[0]}.*"

function likeAncestry () {
	DIR=$1
	PARENT_DIRECTORY=`dirname $DIR`
	if [[ $PARENT_DIRECTORY != $DIR ]]
	then
		likeAncestry $PARENT_DIRECTORY
	fi
	DIRS+=($1)
}

function likeDescendants() {
	IFS=$'\t\n'
	DIRS+=(`find . -regextype posix-extended -regex "${FILTER}"`) 	
	unset $IFS #or IFS=$' \t\n'
}

likeAncestry `pwd`
likeDescendants

while true; do
	let i=0
	LAST_DIRECTORY=""
	FILTERED_DIRS=()
	for DIR in ${DIRS[@]}
	do
		if [[ "${DIR#${LAST_DIRECTORY}}" =~ ${FILTER} ]]
			then
			(( i++ ))
			echo $i ${DIR}
			FILTERED_DIRS+=(${DIR})
			LAST_DIRECTORY=${DIR}
		fi
	done

	if [[ $i == 1 ]]
		then
			if [[ -d ${FILTERED_DIRS[0]} ]]
				then
					cd ${FILTERED_DIRS[0]}
				else
					cd `dirname ${FILTERED_DIRS[0]}`
			fi
			break	
	fi
	DIRS=( "${FILTERED_DIRS[@]}" )
	read FILTER
done
