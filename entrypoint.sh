#!/bin/bash

cat - > sequence.fna

conda run -n pangolin pangolin sequence.fna > /dev/null 2> /dev/null

cat lineage_report.csv | python3 csv2json.py
