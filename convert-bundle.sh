#!/bin/bash
set -euo pipefail

curl -L "https://s3.amazonaws.com/ds2002-resources/labs/lab3-bundle.tar.gz" -o lab3-bundle.tar.gz

tar -xzf lab3-bundle.tar.gz

TSV_FILE=$(find . -type f -name "*.tsv" | head -1)

awk '!/^[[:space:]]*$/' "$TSV_FILE" > cleaned.tsv

tr '\t' ',' < cleaned.tsv > cleaned.csv

ROWS=$(($(wc -l < cleaned.csv) - 1))

echo "Data rows remaining: $ROWS"

tar -czf converted-archive.tar.gz cleaned.csv