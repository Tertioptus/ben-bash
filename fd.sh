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
			FILTERED_DIRS+=(${DIR})
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
