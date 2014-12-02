#!/bin/bash

if [ "$#" -eq 0 ]
   then
        echo ""
        echo "Highlights output based on regex and color id"
        echo "Usage: cat log.txt | highlight.sh pattern1 31 pattern2 34 pattern 3 32"
        echo ""
        echo "Color     ID"
        echo "Black     30"
        echo "Red       31"
        echo "Green     32"
        echo "Yellow    33"
        echo "Blue      34"
        echo "Magenta   35"
        echo "Cyan      36"
        echo "White     37"
        echo ""
        exit 1
fi

while [ $# -gt 0 ]
do
 COMMAND=$COMMAND's/'$1$'/\033[01;'$2$'m\033[K\\0\033[m\033[K/g\n'
 shift;shift;
done

sed -e "$COMMAND"
