#!/bin/bash

fasta="${1}"

conda run -n lineage-env lineage /tmp/"${fasta}" > /dev/null 2> /dev/null

cat analysis/lineage_report.txt
