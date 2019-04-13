#! /bin/bash

ALLOWED_IP=$(dig +short $RPC_CLIENT_HOST)

sed -i "s/ALLOWED_IP/${ALLOWED_IP}/g" bitcoin.conf

bitcoind -datadir=/data -prune=551 -server -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD -conf=/project/bitcoin.conf
