#!/usr/bin/env python3

import argparse
import sys
import time
import os
import datetime
from mfutil import BashWrapper

DESCRIPTION = "block until influxdb is up (return code: 0) or " \
    "30s timeout (return code: 1)"
INFLUXDB_PORT = int(os.environ['MFADMIN_INFLUXDB_HTTP_PORT'])
INFLUXDB_COMMAND = "influx -port %i -precision rfc3339 " \
    "-execute 'SHOW DATABASES'" % INFLUXDB_PORT

parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.parse_args()

before = datetime.datetime.now()
while True:
    elapsed = (datetime.datetime.now() - before).total_seconds()
    if elapsed > 30:
        print("timeout")
        sys.exit(1)
    x = BashWrapper(INFLUXDB_COMMAND)
    if x:
        break
    else:
        print(x)
    time.sleep(1)
sys.exit(0)
