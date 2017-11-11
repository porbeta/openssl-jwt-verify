#!/bin/sh

infile=$1

if [ -n "$infile" ]; then
	cat $infile | sed -e 's:_:/:g' | sed -e 's/-/+/g' | awk '{ i = $1; while(length(i) % 4 != 0) { i = i"=" } print i }' | base64 --decode
else
	read in
	echo -n "$in" | sed -e 's:_:/:g' | sed -e 's/-/+/g' | awk '{ i = $1; while(length(i) % 4 != 0) { i = i"=" } print i }' | base64 --decode
fi
