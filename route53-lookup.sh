#!/bin/bash

# LOOKUP_KEY pode ser "Value" ou "Name"
LOOKUP_VALUE="$1"
LOOKUP_KEY=${LOOKUP_KEY:-"Value"}

for id in $(aws route53 list-hosted-zones | jq -r '.HostedZones|.[].Id' | grep -oP "/hostedzone/(.*?)$" | cut -d"/" -f3); do
    #set -x
    
    case $LOOKUP_KEY in
    "Value")
        JQ_FILTER='.ResourceRecordSets|.[].ResourceRecords|.[]?.Value'
        ;;
    "Name")
        JQ_FILTER='.ResourceRecordSets|.[].Name'
        ;;
    esac

    RECORD_SETS=`aws route53 list-resource-record-sets --hosted-zone-id=$id | jq -r "$JQ_FILTER"`
    if [ ! -z $LOOKUP_VALUE ] && echo "$RECORD_SETS" | grep -q "$LOOKUP_VALUE"; then
        echo "$LOOKUP_VALUE encontrado na hosted zone com ID $id"
    elif [ -z $LOOKUP_VALUE ]; then
        echo "$RECORD_SETS"
    fi
done
