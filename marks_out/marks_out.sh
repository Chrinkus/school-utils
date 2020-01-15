#! /bin/bash

# marks_out: extract final mark data from '.csv' output

extract_records() {
	while read line; do
		if [[ "$line" =~ ^#[[:digit:]]{7} ]]; then
			echo "$line"
		fi
	done
}

extract_records |
	sed -E 's/#(.*)/\1/' |
	awk -F, '{ printf "%s\t%-20s%-15s%.0f\n", $1, $2, $3, $(NF-2) }' |
	sort -k 2,3
