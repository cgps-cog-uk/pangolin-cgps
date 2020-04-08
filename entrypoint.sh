#!/bin/bash

fasta="${1}"

conda run -n lineage-env lineage /tmp/"${fasta}"

mv analysis/lineage_report.txt /tmp/
