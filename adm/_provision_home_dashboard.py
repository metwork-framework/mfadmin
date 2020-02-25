#!/usr/bin/env python3

import requests
import os
import json
from requests.auth import HTTPBasicAuth
import requests_unixsocket

MFMODULE_RUNTIME_HOME = os.environ['MFMODULE_RUNTIME_HOME']
ADMIN_USERNAME = "admin"
ADMIN_PASSWORD = os.environ['MFADMIN_GRAFANA_ADMIN_PASSWORD']
GRAFANA_SOCKET = "%s/tmp/grafana.sock" % MFMODULE_RUNTIME_HOME
GRAFANA_HOST = "localhost"
HOME_DASHBOARD_UID = "lCmsjhHik"

BASE_URL = "http+unix://%s" % GRAFANA_SOCKET.replace('/', '%2F')

requests_unixsocket.monkeypatch()
url = "%s/api/dashboards/uid/%s" % (BASE_URL, HOME_DASHBOARD_UID)
print(url)
dashboard = requests.get(url, auth=HTTPBasicAuth(ADMIN_USERNAME,
                                                 ADMIN_PASSWORD)).json()
print(json.dumps(dashboard, indent=4))
id = dashboard['dashboard']['id']
print(id)

url = "%s/api/user/preferences" % (BASE_URL,)
print(url)
preferences = requests.get(url, auth=HTTPBasicAuth(ADMIN_USERNAME,
                                                   ADMIN_PASSWORD)).json()
print(json.dumps(preferences, indent=4))
preferences['timezone'] = 'utc'
preferences['homeDashboardId'] = id
print(json.dumps(preferences, indent=4))
print(requests.put(url, auth=HTTPBasicAuth(ADMIN_USERNAME, ADMIN_PASSWORD),
                   json=preferences))
url = "%s/api/org/preferences" % (BASE_URL,)
print(url)
print(requests.put(url, auth=HTTPBasicAuth(ADMIN_USERNAME, ADMIN_PASSWORD),
                   json=preferences))
