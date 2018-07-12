#!/bin/bash


wget $1 -O /tmp/tab 2>/dev/null

xmllint --nocdata --xpath '//*[@id="xte-view"]' --html /tmp/tab >/tmp/parsed 2>/dev/null

# set separator to null so that spaces in strings are preserved
IFS=''
divcount=0
while true; do
    divcount=$(( divcount + 1 ))
        
    # extract a verse (a group of lines)
    xmllint --xpath "//div[1]/div[$divcount]" --html /tmp/parsed 2>/dev/null | sed 's/<div class="song">//;s/<\/div>//' > /tmp/verse
    if [ ! -s /tmp/verse ]; then
        exit
    fi
    # add a newline otherwise looping screws up
    echo >> /tmp/verse
    # cycle through single lines
    while read line; do
        #separate all chords on newlines for easier parsing
        echo $line | sed 's/<sup>/\n<sup>/g ; s/<\/sup>/<\/sup>\n/g' > /tmp/words
        # load one line at a time; if it is not a chord, print spaces, print chords otherwise
        while read words; do
            echo $words | tr -d '\n' | sed -E '
                /^<sup>/!        s/./\x1b[1C/g;
                /^<sup>/         s/<sup>(.*)<\/sup>/\x1b[s\1\x1b[u/g;
                '
        done < /tmp/words
        # newline
        echo
        # load one line at a time, but this time print the lyrics, and ignore the chords
        while read words; do
            echo $words | tr -d '\n' | sed -E 's/<sup>.*<\/sup>//g'
        done < /tmp/words
        echo
    done < /tmp/verse
done
