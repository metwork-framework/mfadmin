#!/usr/bin/env python3

import argparse
import sys
import time
import requests
from requests.auth import HTTPBasicAuth
import os
import datetime

DESCRIPTION = "block until grafana is up (return code: 0) or " \
    "30s timeout (return code: 1)"
GRAFANA_PORT = int(os.environ['MFADMIN_GRAFANA_PORT'])
GRAFANA_URL = "http://127.0.0.1:%i/api/admin/stats" % GRAFANA_PORT

parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.parse_args()

before = datetime.datetime.now()
while True:
    elapsed = (datetime.datetime.now() - before).total_seconds()
    if elapsed > 30:
        print("timeout")
        sys.exit(1)
    try:
        r = requests.get(GRAFANA_URL, auth=HTTPBasicAuth('admin', 'admin'),
                         timeout=10)
        if r.status_code == 200:
            break
    except Exception:
        pass
    time.sleep(1)
sys.exit(0)
