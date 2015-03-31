#!/bin/bash

args=("$@")
DIRS=()
FILTER=".*${args[0]}.*" #Use first paramet to create regex filter

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
	#Unset space as a delimiter, so that find returns paths with
	# spaces in full.  Then reset that control after execution
	IFS=$'\t\n'
	DIRS+=(`find . -regextype posix-extended -iregex "${FILTER}"`) 	
	unset $IFS #or IFS=$' \t\n'
}

likeAncestry `pwd` #Search up current path
likeDescendants

while true; do
	let i=0
	LAST_DIRECTORY=""
	FILTERED_DIRS=()
	for DIR in ${DIRS[@]}
	do
		#Compare directory minus last recorded directory against
		# filter to add only uniquely rooted file paths
		shopt -s nocasematch
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
			#Check if lone path is a directory or file
			if [[ -d ${FILTERED_DIRS[0]} ]]
				then
					cd ${FILTERED_DIRS[0]}
				else
					#If file, change to parent directory
					cd `dirname ${FILTERED_DIRS[0]}`
			fi
			break	
	fi
	DIRS=( "${FILTERED_DIRS[@]}" )
	read FILTER
done
