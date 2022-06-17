#!/bin/bash

if [ "$#" -ne 1 ]; then
        echo "Usage: $0 file.csv"
        exit 1
fi

FILE=$1

# Field widths
ID=12
LAST=16
FIRST=12
EMAIL=32

# Printf format string
FMT_HEAD="%-${ID}s %-${EMAIL}s %-${LAST}.${LAST}s %-${FIRST}.${FIRST}s %-s\n\n"
FMT_LINE="%-${ID}s %-${EMAIL}s %-${LAST}.${LAST}s %-${FIRST}.${FIRST}s %3.0f\n"

function print_line() {
        while read id last first email grade; do
                printf "${FMT_LINE}" "$id" "$email" "$last" "$first" "$grade"
        done
}


# Print Header
printf "${FMT_HEAD}" "STUDENT ID" "EMAIL" "LAST NAME" "FIRST NAME" "GRADE"

# Print Lines
cat "$FILE"             \
        | tail -n +2    \
        | tr ',' '\t'   \
        | cut -f1-5     \
        | sort -k2 -k3  \
        | print_line

