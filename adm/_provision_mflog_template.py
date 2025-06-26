#!/usr/bin/env python3

import os
import json
import sys
import requests
from mflog import get_logger

ES_PORT = int(os.environ['MFADMIN_ELASTICSEARCH_HTTP_PORT'])
ES_BASE_URL = "http://127.0.0.1:%i" % ES_PORT
LOG = get_logger("_provision_mflog_template")

url = "%s/_template/template_mflog" % ES_BASE_URL
template = {
    "index_patterns": ["mflog-*"],
    "settings": {
        "index.number_of_replicas": 1,
        "index.refresh_interval": "10s",
        "index.translog.sync_interval": "1m",
        "index.translog.durability": "async"
    },
    "mappings": {
        "dynamic_templates": [
            {
                "strings_as_keyword": {
                    "match_mapping_type": "string",
                    "mapping": {
                        "ignore_above": 256,
                        "type": "keyword"
                    }
                }
            }
        ],
        "date_detection": False,
        "properties": {
            "@timestamp": {
                "type": "date"
            },
            "timestamp": {
                "type": "date"
            },
            "event": {
                "type": "text"
            },
            "pid": {
                "type": "integer"
            }
        }
    }
}

res = requests.put(url, data=json.dumps(template),
                   headers={"Content-Type": "application/json"})
if res.status_code != 200:
    LOG.warning("HTTP/%i during PUT %s with reply: %s" % (res.status_code, url,
                                                          res.text))
    sys.exit(1)

LOG.info("Template: %s set" % url)

# We prefere to delete all mflog indices after changing the mapping
requests.delete("%s/mflog-*" % ES_BASE_URL)

sys.exit(0)
