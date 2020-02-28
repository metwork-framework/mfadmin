# Quickstart

## Installation

**On a Linux CentOS 6, 7 or 8 box**

??? question "What about other Linux distributions?"
    This quickstart is easily adaptable to other Linux distributions. To install
    on your favorite one, have a look at the [complete installation guide]({{installation_guide}}).

```bash

# AS ROOT USER

# First, we configure the Metwork Framework repository for stable releases
cat >/etc/yum.repos.d/metwork.repo <<EOF
[metwork_stable]
name=MetWork Stable
baseurl=http://metwork-framework.org/pub/metwork/releases/rpms/stable/portable/
gpgcheck=0
enabled=1
metadata_expire=0
EOF

# Then we install a minimal version of mfadmin module
yum -y install metwork-mfadmin

# Done :-) But completly useless without following extra steps

# Then let's install the optional metrics layer for dealing with "metrics"
yum -y install metwork-mfadmin-layer-metrics

# Then let's install the optional logs layer for dealing with "logs"
yum -y install metwork-mfadmin-layer-logs

# To feed this fresh mfadmin instance, we are going to install a little mfsysmon module
yum -y install metwork-mfsysmon
```

## Starting services

```console

# AS ROOT USER

/etc/init.d/metwork start mfadmin
/etc/init.d/metwork start mfsysmon

```

??? question "`/etc/init.d/metwork` is a little bit old-fashioned, isn't it?"
    Yes, but it works with CentOS 6, 7 and 8! But of course, you can also use
    `service` or `systemctl` command to start the `metwork` service.

## Use the web UI

Open a browser on: http://localhost:15605

!!! note
    If you installed on a remote host, of course, change `localhost` by your "remote hostname` !
