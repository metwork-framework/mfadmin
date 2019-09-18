#!/bin/bash

"${MFMODULE_HOME}/opt/metrics/opt/grafana/bin/grafana-cli" -d admin reset-admin-password --config "${MFMODULE_RUNTIME_HOME}/tmp/config_auto/grafana.ini" --homepath "${MFMODULE_HOME}/opt/metrics/opt/grafana" "${MFADMIN_GRAFANA_ADMIN_PASSWORD}"
