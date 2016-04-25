#!/bin/sh

# run as root
# pipe to something like /usr/share/nginx/www/stats.csv
# Wherever stats.csv is in webroot

zcat -f /var/log/nginx/access.log* | awk -F " " '{print $4}' | cut -d ':' -f 1,2,3 | sed 's/\[//;s,/, ,g;s/:/ /g' | sort -k 2M -k 1 | uniq -c | awk '{ print $3 " " $2 " " $4 " " $5 ":" $6 ", " $1}' | sed '1s/^/Date, Requests\n/'


# Todo: make prettier and just use all the awk.  This is rather quick and dirty.
