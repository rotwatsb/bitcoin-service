#!/bin/bash

while [ -z "$ALLOWED_IP" ]
do
    sleep 1
    echo "Trying to resolve ${RPC_CLIENT_HOST} ..."
    ALLOWED_IP=$(dig +short $RPC_CLIENT_HOST)
done

echo "Allowed IP: $ALLOWED_IP"

sed -i "s/ALLOWED_IP/${ALLOWED_IP}/g" bitcoin.conf

bitcoind -datadir=/data -prune=551 -server -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD -conf=/project/bitcoin.conf

while [ -z "$SERVER_RESPONSE" ] || [[ ! $SERVER_RESPONSE =~ "bestblockhash" ]]
do
    sleep 1
    SERVER_RESPONSE=$(curl --user $RPC_USER:$RPC_PASSWORD --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/)
done
