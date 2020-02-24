#! /bin/bash

# marks_out: extract final mark data from '.csv' LEARN export
#
# prints to stdout by default.
#
# -f, --file
#	prints to '.txt' file with name generated from input
#
# -q, --quiet
#	no diagnostic messages are printed

extract_records() {
	while read line; do
		if [[ "$line" =~ ^#[[:digit:]]{7} ]]; then
			echo "$line"
		fi
	done
}

extract_out_filename() {
	echo "$1" |
		sed -E 's/^([A-Z]{4}-[0-9]{4}).*([0-9]{6}).*$/\1_\2.txt/'
}

logfile=/dev/stdout
verbose=1

while [[ $# -gt 1 ]]; do
	case "$1" in
		-f|--file)
			logfile=$(extract_out_filename "$2")
			;;
		-q|--quiet)
			verbose=0
			;;
	esac
	shift
done

if [[ $verbose -eq 1 ]]; then
	echo "Outputting to ${logfile}.."
fi

cat "$1" |
	extract_records |
	sed -E 's/#(.*)/\1/' |
	awk -F, '{ printf "%s\t%-20s%-15s%.0f\n", $1, $2, $3, $4 }' |
	sort -k 2,3
