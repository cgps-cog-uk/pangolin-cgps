#!/bin/bash

cat - > sequence.fna

conda run -n lineage-env lineage /tmp/sequence.fna > /dev/null 2> /dev/null

cat analysis/lineage_report.csv
