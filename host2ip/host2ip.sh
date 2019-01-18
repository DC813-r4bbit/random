#!/bin/bash

# Change this
FILE=$(cat /path/to/hostnames.txt)

for h in $FILE; do
    printf "$h\t$(ping -c1 "$h" | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')\n"
done
