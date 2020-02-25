#!/usr/bin/env python3

import argparse
import sys
import time
import requests
from requests.auth import HTTPBasicAuth
import os
import datetime
import requests_unixsocket

MFMODULE_RUNTIME_HOME = os.environ['MFMODULE_RUNTIME_HOME']
DESCRIPTION = "block until grafana is up (return code: 0) or " \
    "30s timeout (return code: 1)"
GRAFANA_SOCKET = "%s/tmp/grafana.sock" % MFMODULE_RUNTIME_HOME
GRAFANA_URL = "http+unix://%s/api/admin/stats" % \
    GRAFANA_SOCKET.replace('/', '%2F')
ADMIN_PASSWORD = os.environ['MFADMIN_GRAFANA_ADMIN_PASSWORD']

parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.parse_args()

requests_unixsocket.monkeypatch()
before = datetime.datetime.now()
while True:
    elapsed = (datetime.datetime.now() - before).total_seconds()
    if elapsed > 30:
        print("timeout")
        sys.exit(1)
    try:
        r = requests.get(GRAFANA_URL, auth=HTTPBasicAuth('admin',
                                                         ADMIN_PASSWORD),
                         timeout=10)
        if r.status_code == 200:
            break
        if r.status_code == 401:
            # maybe the password is not updated
            os.system("_force_grafana_admin_password.sh")
    except Exception:
        pass
    time.sleep(1)
sys.exit(0)
