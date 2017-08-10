#!/bin/bash

#################################################
# MasterChen's "Get Off The Queue!" SCript      #
# Version 1.0b 2016/06/24                       #
#################################################

# Sometimes, co-workers forget to logoff the queue, which interrupts call flow dudring after hours. This script logs everyone off at 1700.

# Setup cron with "00 17 * * * ./queue-logoff.sh"

CNTR=`/usr/sbin/asterisk -rx "queue show 333" | grep -c "from-queue"`

for (( c=1; c<=$CNTR; c++ ))
do
        mem=`/usr/sbin/asterisk -rx "queue show 333" | grep -m1 "from-queue" | cut -d"/" -f2 | tr -d '[a-z]@-'`
        echo $mem
        cmmd=`/usr/sbin/asterisk -rx "queue remove member Local/$mem@from-queue/n from 333"`
        echo $cmmd

done
