#!/bin/bash

cd ${MFADMIN_HOME}/opt/ldap || exit 1

export REPAIRE_JWT_SECRET=$(cat "${MFMODULE_RUNTIME_HOME}/var/uuid")
export REPAIRE_LDAP_BIND_WHO="${MFADMIN_LDAP_BIND_WHO}"
export REPAIRE_LDAP_BIND_PASS="${MFADMIN_LDAP_BIND_PASS}"
export REPAIRE_LDAP_URL="${MFADMIN_LDAP_URL}"
export REPAIRE_LDAP_BASE="${MFADMIN_LDAP_BASE}"
export REPAIRE_LDAP_STARTTLS="${MFADMIN_LDAP_STARTTLS}"
export REPAIRE_COOKIE_NAME="mfadmin_token"
exec layer_wrapper --layers=ldap@mfadmin -- uvicorn repaire.api.infra.main:app --port=$1 --workers=1 
