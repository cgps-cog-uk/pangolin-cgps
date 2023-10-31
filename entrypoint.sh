#!/bin/bash

set -eu -o pipefail

cat - > sequence.fna

NUM_SEQUENCES=$(grep -E "^>" sequence.fna | wc -l)
if [[ $NUM_SEQUENCES -gt 1 ]]; then echo "Only expected 1 sequence, not ${NUM_SEQUENCES}" 2>&1; exit 1; fi

conda run -n pangolin pangolin --use-assignment-cache sequence.fna > /dev/null 2> /dev/null

python csv_reports_to_json.py lineage_report.csv .pangolin_version .pangolin_data_version
