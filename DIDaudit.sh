#!/bin/bash

# DIDaudit.sh by MasterChen(@chenb0x) c2018

# Quickly check available phone numbers (DIDs) against numbers in use on the VoIP network
while read line do
	if grep -q $line /path/to/client/configs/*; then
		echo "$line found on network."
		echo $line >> 2018DIDlist_ACTIVE.txt
		sed -i "/$line/d" 2018DIDlist_IDLE.txt
	else
		echo "$line available"
	fi

done < 2018DIDlist_IDLE.txt
