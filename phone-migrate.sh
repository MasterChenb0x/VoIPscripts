#!/bin/bash

clear

echo "############################################################"
echo "MasterChen's script for converting IP addresses quickly"
echo " 2015.12.11 v 1.0b - @chenb0x"
echo "############################################################"

# Quickly changes IP addreses in xml config files for phone migrations from old to new PBXes

echo "Client?"
read CLIENT
echo "You will be changing:" $CLIENT
sleep 3
echo "What is the old IP?"
read OLDIP
echo "What will be the new IP?"
read NEWIP

echo "You will be changing $CLIENT from $OLDIP to $NEWIP. Ctrl-c if this is incorrect!!"
sleep 8
for X in $( ls | grep $CLIENT ); do
        echo $X
        sed -i s/$OLDIP/$NEWIP/g $X
done
