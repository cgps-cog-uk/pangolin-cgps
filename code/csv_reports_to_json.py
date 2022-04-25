import csv
import json
import sys
import os

lineage_report = sys.argv[1]
pangolin_version_file = sys.argv[2]

with open(pangolin_version_file, 'r') as v_fh:
    pangolin_version = v_fh.readline().rstrip()

# read in lineage report
if os.path.exists(lineage_report):
    with open(lineage_report) as csv_file:
        reader = csv.DictReader(csv_file)
        lineage_info = next(reader)

    # Add the pangolin and pangoLEARN versions
    lineage_info['pangolin_version'] = pangolin_version
    lineage_info['pangolin_data_version'] = lineage_info['version']
    del lineage_info['version']

    # convert to JSON
    print(json.dumps(lineage_info))
else:
    print("Lineage report not found")
    sys.exit(1)
