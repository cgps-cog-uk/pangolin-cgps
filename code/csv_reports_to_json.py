import csv
import json
import sys
import os

lineage_report = sys.argv[1]
pangolin_version_file = sys.argv[2]
pangoLEARN_version_file = sys.argv[3]

with open(pangolin_version_file, 'r') as v_fh:
    pangolin_version = v_fh.readline().rstrip()

with open(pangoLEARN_version_file, 'r') as v_fh:
    pangoLEARN_version = v_fh.readline().rstrip()

# read in lineage report
if os.path.exists(lineage_report):
    with open(lineage_report) as csv_file:
        reader = csv.DictReader(csv_file)
        lineage_info = next(reader)

    # Add the pangolin and pangoLEARN versions
    lineage_info['pangolin_version'] = pangolin_version
    lineage_info['pangoLEARN_version'] = pangoLEARN_version

    # Rename the QC fields to be compatible with the website.
    lineage_info['status'] = 'passed_qc' if lineage_info['qc_status'] == 'pass' else lineage_info['qc_status']

    # convert to JSON
    print(json.dumps(lineage_info))
else:
    print("Lineage report not found")
    sys.exit(1)
