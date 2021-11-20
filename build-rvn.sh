#!/bin/bash

ver=$1

if [ x$ver == "x" ]; then
	echo "Version not specified"
	exit 1
fi

docker build rvn --pull --build-arg RVN_WORKER=ang \
	-t andywarduk/rvnminer:$ver \
	-t andywarduk/rvnminer:latest

