#!/bin/bash

args=("$@")
DIRS=()
FILTER=""

function likeAncestry() {
	DIRS+=(`pwd`)
}

function likeDescendants() {
	DIRS+=(`find . -name "*${args[0]}*"`) 	
}

likeAncestry
likeDescendants

while true; do
	let i=0
	FILTERED_DIRS=()
	for DIR in ${DIRS[@]}
	do
		if [[ "${DIR}" =~ ${FILTER} ]]
		 then
			((i++))
			echo $i ${DIR}
			FILTERED_DIRS+=${DIR}
		fi
	done

	if [[ $i == 1 ]]
		then
			echo "blah"
			break	
	fi
	DIRS=FILTERED_DIRS
	read FILTER
done
