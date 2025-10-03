#!/bin/bash

set -eu

cd /src
set -x


echo -e "[metwork_${DEP_BRANCH}]" >/etc/yum.repos.d/metwork.repo
echo -e "name=Metwork Continuous Integration Branch ${DEP_BRANCH}" >> /etc/yum.repos.d/metwork.repo
echo -e "baseurl=http://metwork-framework.org/pub/metwork/continuous_integration/rpms/${DEP_BRANCH}/${OS_VERSION}/" >> /etc/yum.repos.d/metwork.repo
echo -e "gpgcheck=0\n\enabled=1\n\metadata_expire=0\n" >>/etc/yum.repos.d/metwork.repo

    yum -y localinstall ./rpms/metwork-mfadmin*.rpm
    yum -y install make

    su --command="mfadmin.init" - mfadmin || echo "mfadmin.init has failed"
    su --command="mfadmin.start" - mfadmin || echo "mfadmin.start has failed"
    su --command="mfadmin.status" - mfadmin || echo "mfadmin.status has failed"
    if test -d "integration_tests"; then chown -R mfadmin integration_tests; cd integration_tests; su --command="cd `pwd`; ./run_integration_tests.sh" - mfadmin; cd ..; fi
    su --command="mfadmin.stop" - mfadmin

