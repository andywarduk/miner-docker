# ---- Build image ----
FROM ubuntu:latest AS build

# Install essential ubuntu packages
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
        wget \
        git \
        cmake \
        gnupg \
        software-properties-common \
        libgl-dev

# Create and switch to the build directory
RUN mkdir /build

WORKDIR /build

# Set up nvidia CUDA repository and install cuda
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin \
 && mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub \
 && add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" \
 && apt-get update \
 && apt-get -y install cuda

# Clone the ethminer repository
RUN git clone --recurse-submodules https://github.com/ethereum-mining/ethminer

# Create the ethminer build directory and switch to it
WORKDIR /build/ethminer

RUN mkdir build

WORKDIR /build/ethminer/build

# Run cmake to build ethminer
RUN cmake ..

RUN cmake --build .

# Install ethminer
RUN make install


# ---- Final image ----
FROM ubuntu:latest

# Install ca-certificates for ssl connections
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
        ca-certificates

RUN apt-get clean

# Copy ethminer binaries from the build image
COPY --from=build /usr/local/bin/ethminer /usr/local/bin
COPY --from=build /usr/local/bin/kernels/ /usr/local/bin

# Copy the mine script to root
WORKDIR /

COPY mine.sh .
RUN chmod u+x mine.sh

# Expose port 8080 for api access
EXPOSE 8080

# Miner arguments
ARG ETH_ID
ENV ETH_ID=${ETH_ID:-0x35B7679448D49e25EB003ad2940BC65305F363c7}

ARG ETH_WORKER
ENV ETH_WORKER=${ETH_WORKER}

ARG ETH_TRANSPORT
ENV ETH_TRANSPORT=${ETH_TRANSPORT:-stratum1+ssl}

ARG ETH_SERVER
ENV ETH_SERVER=${ETH_SERVER:-eu1.ethermine.org:5555}

# Run mine.sh
CMD ./mine.sh
