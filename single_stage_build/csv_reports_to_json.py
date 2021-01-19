import csv
import json
import sys
import os

lineage_report = sys.argv[1]
global_info_report = sys.argv[2]

# read in lineage report
if os.path.exists(lineage_report):
    with open(lineage_report) as csv_file:
        reader = csv.DictReader(csv_file)
        lineage_info = next(reader)

    # read in global info report
    if os.path.exists(global_info_report):
        with open(global_info_report) as csv_file:
            reader = csv.DictReader(csv_file)
            global_info = next(reader)

        # combine reports
        lineage_info.update(global_info)

        # delete duplicate lineage key
        del(lineage_info['Lineage name'])

    # convert to JSON
    print(json.dumps(lineage_info))
else:
    print("Lineage report not found")
    sys.exit(1)
