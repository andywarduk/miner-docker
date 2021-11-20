# ---- Build image ----
FROM ubuntu:20.04 AS build

# Install essential ubuntu packages
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
        wget \
        software-properties-common

# Set up nvidia CUDA repository and install cuda
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin \
 && mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub \
 && add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" \
 && apt-get update \
 && apt-get -y install cuda

CMD /bin/bash
