#!/bin/bash

docker build . -t andywarduk/cuda:latest

if [ $? -eq 0 ]; then
	docker push andywarduk/cuda:latest
fi

