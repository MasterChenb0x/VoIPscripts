#!/bin/bash

#-- Functions
usage() {
	echo "./DIDselect.sh <# of DIDs needed>"
}


if [ $# -eq 0 ]; then
	usage
	exit 0
fi

# Declarations, assignments, and outside variables.
declare -a DIDarray
for (( i=0; i<=$(( $1 - 1 )); i++ )) do
        DIDarray[$i]=`sort -R /home/user/2018DIDlist_IDLE.txt | head -n 1`
done
FREE="Y"
 
# Check if $DID(s) is in use on the VoIP network
for (( x=0; x<=$(( $1 - 1 )); x++ )) do # I thought I'd be able to traverse $(DIDarray[@]} bu that didn't seem to work out so well.
	# echo ${DIDarray[$x]}
	while grep -iq ${DIDarray[$x]} /path/to/client/configs/*; do
		echo "${DIDarray[$x]} found on the network. Grabbing a different one..."
		sed -i "/${DIDarray[$x]}/d" /home/user/2018DIDlist_IDLE.txt
		echo ${DIDarray[$x]} >> /home/user/2018DIDlist_ACTIVE.txt
		echo "${DIDarray[$x]} removed from Idle list."
		DIDarray[$x]=`sort -R /home/user/2018DIDlist_IDLE.txt | head -n 1`
	done

	# Remove DID from Idle list and add to Active list
	echo "${DIDarray[$x]} should be clear to use. Call it first and find out!"
	echo "Was there silence when you called it? (Y/n)"
	read FREE
	if [ $FREE == "Y" ] || [ $FREE == "y" ]; then
        	sed -i "/${DIDarray[$x]}/d" /home/user/2018DIDlist_IDLE.txt
        	echo ${DIDarray[$x]} >> /home/user/2018DIDlist_ACTIVE.txt
        	echo "${DIDarray[$x]} is ready to assign!"
	else
		# Need to remove bad DID and select a new one from Idle list
        	echo "Run the script again to get a new number."
	fi
done

echo "DIDs ready for use"
echo "=================="
for (( c=0; c<=$(( $1 - 1 )); c++ )) do
        echo ${DIDarray[$c]}
done
