#!/bin/bash

args=("$@")
DIRS=()
FILTER=".*${args[0]}.*" #Use first paramet to create regex filter
ROOT_DIRECTORY="."
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
	DIRS+=(`find ${ROOT_DIRECTORY} -regextype posix-extended -iregex "${FILTER}"`) 	
	unset $IFS #or IFS=$' \t\n'
}

#if second parameter exists, use that as root directory to start search
#else, default to current directory and also and path ancestry
if [[ ! -z ${args[1]} ]] 
then
	ROOT_DIRECTORY=${args[1]}
else
	likeAncestry `pwd` #Search up current path
fi

likeDescendants

while true; do
	let i=0
	LAST_DIRECTORY=""
	FILTERED_DIRS=()
	let current_directory_list_count=0
	for DIR in ${DIRS[@]}
	do
		#Compare directory minus last recorded directory against
		# filter to add only uniquely rooted file paths
		shopt -s nocasematch
		(( current_directory_list_count++ ))
		if [[ "${current_directory_list_count}: ${DIR#${LAST_DIRECTORY}}" =~ ${FILTER} ]]
			then
			(( i++ ))
			echo $i:  ${DIR}
			FILTERED_DIRS+=(${DIR})
			
			#Don't record files, only directories
			if [[ -d ${DIR} ]]
			then
				LAST_DIRECTORY=${DIR}
			fi
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
