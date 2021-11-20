#!/bin/bash

ver=$1

if [ x$ver == "x" ]; then
        echo "Version not specified"
        exit 1
fi

docker build . --no-cache --pull -t andywarduk/cuda:$ver -t andywarduk/cuda:latest

if [ $? -eq 0 ]; then
	docker push -a andywarduk/cuda
fi

