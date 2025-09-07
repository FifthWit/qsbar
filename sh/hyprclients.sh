#!/bin/bash

hyprctl clients |
awk '
BEGIN { printf "[" }
/^Window [0-9a-f]/ {
    # Print previous window (if any) before starting new one
    if (NR > 1 && title != "") {
        printf "%s{\"workspace\":%s,\"title\":\"%s\",\"class\":\"%s\",\"pid\":%s}", 
               (n++ ? "," : ""), ws, ttl, cls, pid
    }
    # Start new window
    split($0,a,/ -> /)
    title = a[2]
    sub(/:$/, "", title)
    ws = cls = ttl = pid = ""
    next
}
$1 == "workspace:" { ws = $2 }
$1 == "class:"     { cls = $2 }
$1 == "title:"     { ttl = substr($0, index($0,$2)) }
$1 == "pid:"       { pid = $2 }
END {
    # Print the last window
    if (title != "") {
        printf "%s{\"workspace\":%s,\"title\":\"%s\",\"class\":\"%s\",\"pid\":%s}", 
               (n++ ? "," : ""), ws, ttl, cls, pid
    }
    print "]"
}'