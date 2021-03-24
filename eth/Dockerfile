# ---- Build image ----
FROM andywarduk/cuda AS build

# Install essential ubuntu packages
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
        git \
        cmake \
        gnupg \
        libgl-dev

# Create and switch to the build directory
RUN mkdir /build

WORKDIR /build

# Clone the ethminer repository
RUN git clone --recurse-submodules https://github.com/ethereum-mining/ethminer

# Create the ethminer build directory and switch to it
RUN mkdir ethminer/build

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
