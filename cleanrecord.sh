#!/bin/bash

# This script is used to quickly clear out voice recordings and clear up space. If a client is recording every phone call, hard drive space will fill up quickly.

clear
echo "##############################################"
echo " Asterisk Recording Cleanup Script"
echo "          by MasterChen"
echo "##############################################"

echo "Enter the year:"
read YEAR
echo "Enter how many months of recordings to clear:"
read MONTHS

for x in $( ls /var/spool/asterisk/monitor/$YEAR/ | head -n $MONTHS); do
        echo "Removing the $x Directory"
        rm -rf /var/spool/asterisk/monitor/$YEAR/$x
done

