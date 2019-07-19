#!/usr/bin/env python3

import argparse
import requests
import os
import sys
from mflog import get_logger
import logging

DESCRIPTION = "export a kibana dashboard on stdout"
KIBANA_PORT = int(os.environ['MFADMIN_KIBANA_HTTP_PORT'])
KIBANA_PATTERN = \
    "http://127.0.0.1:%i/api/kibana/" \
    "dashboards/export?dashboard=%s" % (KIBANA_PORT, "%s")
LOGGER = get_logger("export_kibana_dashboard")

parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.add_argument("DASHBOARD_ID", help="dashboard id")
args = parser.parse_args()

url = KIBANA_PATTERN % args.DASHBOARD_ID
#  change the log level of the urllib3 library for not having the debug
#  messages on the stdout output
logging.getLogger('urllib3').setLevel(logging.WARNING)
r = requests.get(url, timeout=30)
if r.status_code != 200:
    LOGGER.warning("can't get %s with status_code: %i" % (url, r.status_code))
    print(r.text)
    sys.exit(1)

try:
    x = r.json()["objects"][0]["error"]["message"]
    LOGGER.warning("can't get %s with message: %s", x)
    print(r.text)
except Exception:
    pass

print(r.text)
