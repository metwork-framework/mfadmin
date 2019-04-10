#!/usr/bin/env python3

import argparse
import requests
import os
import sys
import json
from mflog import get_logger

DESCRIPTION = "import a kibana dashboard from stdin"
KIBANA_PORT = int(os.environ['MFADMIN_KIBANA_HTTP_PORT'])
KIBANA_URL = \
    "http://127.0.0.1:%i/api/kibana/" \
    "dashboards/import?force=true" % (KIBANA_PORT, )
LOGGER = get_logger("import_kibana_dashboard")

parser = argparse.ArgumentParser(description=DESCRIPTION)
args = parser.parse_args()

stdin_raw = sys.stdin.read()
try:
    j = json.loads(stdin_raw)
except Exception:
    LOGGER.warning("stdin is not a valid JSON")
    sys.exit(1)

if "objects" not in j:
    LOGGER.warning("stdin is not a valid dashboard JSON")
    sys.exit(1)

r = requests.post(KIBANA_URL, timeout=30, data=json.dumps(j),
                  headers={"kbn-xsrf": "reporting"})
if r.status_code != 200:
    LOGGER.warning("can't POST to %s with status_code: %i" % (KIBANA_URL,
                                                              r.status_code))
    print(r.text)
    sys.exit(1)

print("Done")
