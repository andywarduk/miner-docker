#!/bin/bash

# Check parameters
if [ "x$ETH_ID" == "x" ]; then
    echo "No wallet ID specified"
    exit 1
fi

if [ "x$ETH_WORKER" == "x" ]; then
    ETH_WORKER=$(hostname)
fi

if [ "x$ETH_TRANSPORT" == "x" ]; then
    echo "No transport mechanism specified"
    exit 1
fi

if [ "x$ETH_SERVER" == "x" ]; then
    echo "No server specified"
    exit 1
fi

# Call ethminer in a loop
while true
do
    ethminer -U -P ${ETH_TRANSPORT}://${ETH_ID}.${ETH_WORKER}@${ETH_SERVER} --HWMON 2 --api-port 8080
done
