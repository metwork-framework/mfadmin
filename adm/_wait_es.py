#!/usr/bin/env python3

import argparse
import sys
import time
import requests
import os
import datetime

DESCRIPTION = "block until ES is up (return code: 0) or " \
    "90s timeout (return code: 1)"
ES_PORT = int(os.environ['MFADMIN_ELASTICSEARCH_HTTP_PORT'])
ES_URL = "http://127.0.0.1:%i/_cluster/health?wait_for_status=yellow" % ES_PORT

parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.parse_args()

before = datetime.datetime.now()
while True:
    elapsed = (datetime.datetime.now() - before).total_seconds()
    if elapsed > 90:
        print("timeout")
        sys.exit(1)
    try:
        r = requests.get(ES_URL, timeout=10)
        if r.status_code == 200:
            break
    except Exception:
        pass
    time.sleep(1)
sys.exit(0)
