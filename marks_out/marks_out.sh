#! /bin/bash

# marks_out: extract final mark data from '.csv' LEARN export
#
# prints to stdout by default.
#
# -o, --outfile
#	prints to '.txt' file with name generated from input
#
# -u, --unix
#	output has UNIX-style line-endings (default)
#
# -w, --windows
#	output has DOS-style line-endings

extract_records() {
	while read line; do
		if [[ "$line" =~ ^#[[:digit:]]{7} ]]; then
			echo "$line"
		fi
	done
}

format_line_endings() {
	if [[ $1 -gt 0 ]]; then
		awk 'sub("$", "\r")'
	else
		awk '{ print }'
	fi
}

extract_out_filename() {
	echo "$1" |
		sed -E 's/^([A-Z]{4}-[0-9]{4})..([0-9]{6}).*$/\1_\2.txt/'
}

WIN=0
OUT=0

while [[ $# -gt 1 ]]; do
	case "$1" in
		-w|--windows)
			WIN=1
			echo "Exporting with Windows line-endings"
			;;
		-u|--unix)
			WIN=0
			echo "Exporting with Unix line-endings"
			;;
		-o|--outfile)
			OUT=1
			;;
	esac
	shift
done

DEST="&1"
if [ $OUT ]; then
	DEST="$(extract_out_filename "$1")"
fi

cat "$1" |
	extract_records |
	sed -E 's/#(.*)/\1/' |
	awk -F, '{ printf "%s\t%-20s%-15s%.0f\n", $1, $2, $3, $4 }' |
	sort -k 2,3 |
	format_line_endings "$WIN" > "$DEST"
