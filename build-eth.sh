#!/bin/bash

ver=$1

if [ x$ver == "x" ]; then
	echo "Version not specified"
	exit 1
fi

docker build eth --build-arg ETH_WORKER=ang -t ethminer-$ver -t andywarduk/ethminer:latest
