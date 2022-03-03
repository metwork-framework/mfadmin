#!/bin/bash

cd ${MFADMIN_HOME}/opt/ldap || exit 1
layer_load ldap@mfadmin
exec uvicorn repaire.api.infra.main:app --reload --port=8000 --workers=1 --log-level=debug
