FROM andywarduk/cuda

# Install essential ubuntu packages
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
        git \
        cmake \
        gnupg \
        libgl-dev \
        ca-certificates

RUN apt-get clean

# Create and switch to the build directory
RUN mkdir /build

WORKDIR /build

# Clone the kawpowminer repository
RUN git clone --recurse-submodules https://github.com/andywarduk/kawpowminer
#RUN git clone --recurse-submodules https://github.com/RavenCommunity/kawpowminer

# Create the kawpowminer build directory and switch to it
RUN mkdir kawpowminer/build

WORKDIR /build/kawpowminer/build

# Run cmake to build kawpowminer
RUN cmake ..

RUN cmake --build .

# Install kawpowminer
RUN make install

# Copy the mine script to root
WORKDIR /

COPY mine.sh .
RUN chmod u+x mine.sh

# Expose port 8080 for api access
EXPOSE 8080

# Miner arguments
ARG RVN_ID
ENV RVN_ID=${RVN_ID:-RKEJ3Tr2qD7qLDqqF8Gt1SEw1gtpDXvxDA}

ARG RVN_WORKER
ENV RVN_WORKER=${RVN_WORKER}

ARG RVN_TRANSPORT
ENV RVN_TRANSPORT=${RVN_TRANSPORT:-stratum+ssl}

ARG RVN_SERVER
ENV RVN_SERVER=${RVN_SERVER:-stratum-ravencoin.flypool.org:3443}

# Run mine.sh
CMD ./mine.sh
