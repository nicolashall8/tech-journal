#!/bin/bash

hostfile=$1
portfile=$2

if [[ ! -f $1 || ! -f $2 ]]
then
        echo "Error: Cannot find file"
        exit 2
fi

echo "host,port"
for host in $(cat $hostfile); do
        for port in $(cat $portfile); do
                timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
                        echo "$host,$port" && echo "$host,$port" >> hosts_scanned.txt
        done
done
