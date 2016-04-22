#!/bin/bash
PASSWORD="<PASSWORD>"
USER="<USERNAME>"
GROUP="<ANYCONNECT_VPN_GROUP"
URL="<ANYCONNECT_URL>"

echo -n $PASSWORD | openconnect --no-cert-check "$URL/$GROUP" --user=$USER --passwd-on-stdin
