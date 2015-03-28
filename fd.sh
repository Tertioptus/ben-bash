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
	let i=1
	for DIR in ${DIRS[@]}
	do
		if [[ "${DIR}" =~ .*${FILTER}.* ]]
		 then
			echo $i ${DIR}
			((i++))
		fi
	done

	if [[ $i == 2 ]]
		then
			echo "blah"
			break	
	fi

	read FILTER
	echo $FILTER
done
