#!/bin/bash

# Test if mfadmin.start/status/stop are ok

su --command="mfadmin.start" - mfadmin
if test $? -ne 0; then
    echo "Test mfadmin.start KO"
    exit 1
else
    echo "Test mfadmin.start OK"
fi
su --command="mfadmin.status" - mfadmin
if test $? -ne 0; then
    echo "Test mfadmin.status KO"
    exit 1
else
    echo "Test mfadmin.status OK"
fi
su --command="mfadmin.stop" - mfadmin
if test $? -ne 0; then
    echo "Test mfadmin.stop KO"
    exit 1
else
    echo "Test mfadmin.stop OK"
fi
exit 0
