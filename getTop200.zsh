#!/bin/zsh

# put in crontab or something
# pipe to /usr/share/nginx/www/top200.html
# or something in webroot

echo "<table>"
IFS=$'\n'
for line in $(zcat -f /var/log/nginx/access.log{,.{1..7},.{1..7}.gz} 2&>/dev/null | grep hls | awk '{ a[$1] += 1 } END { for (v in a) print a[v] " </td><td> " v " </td><td>"}' | sort -nr | head -n 200); do echo "<tr><td> $line "  "$( geoiplookup `echo $line | cut -d " " -f3` -f /usr/share/GeoIP/GeoCity.dat 2>&1 | awk '{print $8 " " $7 " " $6 "</td></tr>"}')";
done
echo "</table>"

