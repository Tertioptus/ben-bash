#!/bin/bash

args=("$@")
DIRS=()

function likeAncestry() {
	DIRS+=(`pwd`)
}

function likeDescendants() {
	DIRS+=(`find . -name "*${args[0]}*"`) 	
}

likeAncestry
likeDescendants

let i=1
for DIR in ${DIRS[@]}
do
	echo $i ${DIR}
	((i++))
done

read filter
echo $filter
