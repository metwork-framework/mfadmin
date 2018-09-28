#!/usr/bin/env python3

import requests
import os
import json

ADMIN_USERNAME = "admin"
ADMIN_PASSWORD = "admin"
GRAFANA_PORT = int(os.environ['MFADMIN_GRAFANA_PORT'])
GRAFANA_HOST = "localhost"
HOME_DASHBOARD_UID = "lCmsjhHik"

BASE_URL = "http://%s:%s@%s:%i" % (ADMIN_USERNAME, ADMIN_PASSWORD,
                                   GRAFANA_HOST, GRAFANA_PORT)

url = "%s/api/dashboards/uid/%s" % (BASE_URL, HOME_DASHBOARD_UID)
print(url)
dashboard = requests.get(url).json()
print(json.dumps(dashboard, indent=4))
id = dashboard['dashboard']['id']
print(id)

url = "%s/api/user/preferences" % (BASE_URL,)
print(url)
preferences = requests.get(url).json()
print(json.dumps(preferences, indent=4))
preferences['timezone'] = 'utc'
preferences['homeDashboardId'] = id
print(json.dumps(preferences, indent=4))
print(requests.put(url, json=preferences))
url = "%s/api/org/preferences" % (BASE_URL,)
print(url)
print(requests.put(url, json=preferences))
