#!/bin/bash

set -e -o pipefail

cat - > sequence.fna

conda run -n pangolin-web pangolin sequence.fna > /dev/null 2> /dev/null

python3 csv_reports_to_json.py lineage_report.csv global_lineage_information.csv
