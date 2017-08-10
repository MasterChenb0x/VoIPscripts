#!/bin/bash

# This script will grab the FreePBX upgrade scripts for firmware.
# It is best to upgrade the FreePBX framework first i.e going from 2.11 to 12 or 13 and then coming back to upgrade firmware with this script.
#This is only grabbign the scripts from freepbx.org, but does NOT initiate any of the scripts.
# The scripts should be ran mmanually since some of them require reboots or certain actions. 
# Please consult freepbx.org for more information.

echo "We are upgrading this server to the latst and greatest!...gradually!"

echo "Making directory in /root/upgradescripts to hold downloads..."
cd /root/
mkdir upgradescripts
cd /root/upgradescripts

for i in {16..21}
do
        wget http://upgrades.freepbxdistro.org/stable/5.211.65/upgrade-5.211.65-$i.sh
done

wget http://upgrades.freepbxdistro.org/stable/6.12.65/upgrade-5.211.65-to-6.12.65-20.sh

for n in {21..32}
do
        wget http://upgrades.freepbxdistro.org/stable/6.12.65/upgrade-6.12.65-$n.sh
done

wget --no-check-certificate https://upgrades.freepbxdistro.org/stable/10.13.66/upgrade-10.13.66-1.sh

chmod +x /root/upgradescripts/*

PBX=`cat /etc/schmooze/pbx-version`
echo "================================================="
echo "Your version of FreePBX Firmware is: $PBX"
echo "================================================="
