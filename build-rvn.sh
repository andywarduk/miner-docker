#!/bin/bash

ver=$1

if [ x$ver == "x" ]; then
	echo "Version not specified"
	exit 1
fi

docker build rvn --build-arg RVN_WORKER=ang -t rvnminer-$ver -t andywarduk/rvnminer:latest
