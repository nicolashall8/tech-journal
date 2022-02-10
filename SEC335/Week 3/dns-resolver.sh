#!/bin/bash

host=$1
dns_server=$2

if [[ $1 == "" || $2 == "" ]]
then
        echo "Error: No network prefix and/or DNS server given."
        exit 2
fi

echo "DNS resolution for $1"

for i in $(seq 0 255); do
        nslookup $host.$i $dns_server | grep '='
done
