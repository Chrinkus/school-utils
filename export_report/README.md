# Export Report

These scripts take an export from a specific web app. When exporting, there are certain fields that are needed ONLY. The expected content includes:

- Org defined ID
- Last Name
- First Name
- Email
- Numeric value of significance

## marksout.sh

Extracts the useful data, discards the rest. Sorts lines and spaces fields nicely. Would recommend to a friend.

## emailer.sh

TODO: Extract all emails into a comma-separated list for mass emailing.

## fileout.sh

TODO: Calls `marksout.sh` and outputs to a file appropriately named according to the input file name.

