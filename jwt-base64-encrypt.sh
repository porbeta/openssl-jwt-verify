#!/bin/sh

infile=$1

if [ -n "$infile" ]; then
	base64 $infile | tr -d '\n' | sed -e 's:/:_:g' | sed -e 's/+/-/g' | sed -e 's/[=]*$//g'
else
	read in
	echo -n "$in" | base64 | tr -d '\n' | sed -e 's:/:_:g' | sed -e 's/+/-/g' | sed -e 's/[=]*$//g'
fi
