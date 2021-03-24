#!/bin/bash

# Check parameters
if [ "x$RVN_ID" == "x" ]; then
    echo "No wallet ID specified"
    exit 1
fi

if [ "x$RVN_WORKER" == "x" ]; then
    RVN_WORKER=$(hostname)
fi

if [ "x$RVN_TRANSPORT" == "x" ]; then
    echo "No transport mechanism specified"
    exit 1
fi

if [ "x$RVN_SERVER" == "x" ]; then
    echo "No server specified"
    exit 1
fi

# Call kawpowminer in a loop
while true
do
    kawpowminer -U -P ${RVN_TRANSPORT}://${RVN_ID}.${RVN_WORKER}@${RVN_SERVER} --HWMON 2 --api-port 8080
done
