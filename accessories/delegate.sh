#!/bin/bash
COUNTER=0
for d in ./*/
do 
	let COUNTER+=1
	(cd  && xp-set `printf "%03d" $COUNTER`)
done
