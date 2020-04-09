import csv
import json
import sys

results = list()
reader = csv.DictReader(sys.stdin)
for line in reader:
    print(json.dumps(line))
    break
