#!/bin/bash

"${MFADMIN_HOME}/opt/metrics/opt/grafana/bin/grafana-cli" --config "${MFMODULE_RUNTIME_HOME}/tmp/config_auto/grafana.ini" --homepath "${MFMODULE_HOME}/opt/metrics/opt/grafana" admin reset-admin-password "${MFADMIN_GRAFANA_ADMIN_PASSWORD}"
