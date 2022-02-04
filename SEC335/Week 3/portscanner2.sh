#!/bin/bash

ip=$1
port=$2

if [[ $1 == "" || $2 == "" ]]
then
	echo "Error: No IP and/or port given."	
	exit 2
fi

for i in $(seq 0 255); do 
	ip=$1.$i

	for ip in $ip; do
		for port in $port; do
			timeout .1 bash -c "echo >/dev/tcp/$ip/$port" 2>/dev/null &&
				echo "ip,port" && echo "$ip,$port"
		done
	done
done
