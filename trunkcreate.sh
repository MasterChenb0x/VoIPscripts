#!/bin/bash

#--
# IAX/SIP Trunk Creator by MasterChen c2018 va0.5

# Functions
usage() {
        echo "IAX/SIP Trunk Creator"
        echo "====================="
        echo "Usage: ./trunkcreate.sh <OPTIONS> [filename]"
        echo "OPTIONS"
        echo "  -h Print this help and exit"
        echo "  -I Select IAX trunk configuration"
        echo "  -S Select SIP trunk configuration (default)"
        echo "  -P Sets PBX address; can be IP or domain name"
        echo "  -D Sets Primary DID of Client"
        echo "  -C Sets Client name"
        echo "  -c Sets Context; either (1)stlv-phones OR (2)stlv-phones-international"
        echo "  -l Sets Channel Limit of Trunk(default 10)"
        echo "EXAMPLES"
        echo "  ./trunkcreate.sh -I|-S -P 192.168.1.1 -D 7028675309 -C MasterChen -c2 -l 10"
}

# Default variable values
CLIENT=""
ACCTCODE=`head /dev/urandom | tr -dc 0-9 | head -c 8` # RNG
PBX=""
PRIMDID=""
SECRET=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16` # secret generation
CONTEXT="stlv-phones"
CHANLIMIT=10
TRUNK="clients-sip"

# Parse and handle arguments
while getopts ":hISP:D:C:c:l:" opt; do
        case $opt in
                I )
                        echo "-> IAX Trunk Selected"
                        TRUNK="clients-iax"
                        ;;
                S )
                        echo "-> SIP trunk selected"
                        TRUNK="clients-sip"
                        ;;
                P ) # Set PBX host
                        PBX=$OPTARG
                        ;;
                D ) # Set Primary DID
                        PRIMDID=$OPTARG
                        ;;
                C ) #Sets Client name for file creation
                        CLIENT=$OPTARG
                        ;;
                c ) # Set context
                        if [ $OPTARG == "2" ]; then
                                CONTEXT='stlv-phones-international'
                                echo $CONTEXT
                        else
                                echo $CONTEXT
                        fi
                        ;;
                l ) # Set channel limit
                        CHANLIMIT=$OPTARG
                        ;;
                \? )
                        echo "Invalid Option$ $OPTARG"
                        ;;
                : )
                        echo "Invalid Option: $OPTARG requires an argument"
                        ;;
                h | * ) # Display Help
                        usage
                        exit 0
                        ;;
        esac
done

# Check for Account Code collisions
ACCTCHK=$( grep "account" /path/to/trunk/configs/ | awk -F= '{ print $2 }' | grep -ic "$ACCTCODE" )
if [ $ACCTCHK -eq 1 ]
then
        echo "Account exists! Odds of that are 100,000,000:1! Congratulations! Re-rolling Account Code..."
        ACCTCODE=`head /dev/urandom | tr -dc 0-9 | head -c 8` # RNG
else
        echo "-> Account available!"
fi

# Print parameters to trunk config file
echo "[$PRIMDID]
accountcode=$ACCTCODE
type=friend
host=$PBX
deny=0.0.0.0/0.0.0.0
permit=$PBX
defaultuser=$PRIMDID
secret=$SECRET
context=$CONTEXT
disallow=all
allow=ulaw
allow=gsm
allow=g729
allow=ilbc
qualify=10000
nat=yes
canreinvite=no
dtmfmode=rfc2833
call-limit=$CHANLIMIT" > /path/to/trunk/configs/$TRUNK/$CLIENT.conf
