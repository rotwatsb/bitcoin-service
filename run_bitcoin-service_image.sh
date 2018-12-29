#!/bin/bash

# run as: ./run_bitcoin-service_image.sh IMAGE_NAME RPC_USER RPC_PASSWORD
RPCU=RPC_USER=$2
RPCP=RPC_PASSWORD=$3

docker run --mount source=peanuts,target=/data -e $RPCU -e $RPCP -p 8333:8333 $1
