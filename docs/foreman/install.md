# Foreman Installation on Rocky Linux 8

> **Please ensure that the steps required prior to installation in the [Installation Guide](./quickstart.md) are adhered to.**

## Dependencies

> **NOTE:** These dependencies may be installed via the [setup-foreman-katello.sh](scripts/foreman-install-dependencies.sh)

### Enable EPEL

```
dnf install epel-release
dnf config-manager --set-enabled powertools
```

### Setup selinux targeted policy

```
dnf install selinux-policy-targeted -y
```

### Enable Foreman Repo

```
dnf install https://yum.theforeman.org/releases/3.9/el8/x86_64/foreman-release.rpm
```

### Enable Katello Repo

https://yum.theforeman.org/katello/4.11/katello/el8/x86_64/
```
dnf install https://yum.theforeman.org/katello/4.11/katello/el8/x86_64/katello-repos-latest.rpm
```

### Enable Katello and Powertools

```
dnf config-manager --set-enabled powertools
dnf module enable katello:el8 
```

#### (Optional) Install bind9-utils for DNS updates

```
dnf install bind9-utils

#Copy over tsig key to /etc/rndc.key
chown -v 640 /etc/rndc.key
chown -v root:named /etc/rndc.key

#Add foreman-proxy user to named group
usermod -a -G named foreman-proxy
```

#### (Optional) Install xinetd for TFTP

```
dnf install xinetd
```

## Generate Certificates

Generate the certificates that should be used for the Foreman install.

This guide covers both Google Cloud DNS and Cloudflare. See the [Setup SSL Certificates](./quickstart.md#setup-ssl-certificates) section of the quickstart guide for details.

> **It is much easier to generate certs first then try to add them to an install.**

## Install Foreman+Katello

> **NOTE:** While using lots of options may seem cumbersome I have found it to be the best way to have your install be fully reproducible. The answers file does change over versions and does not provide output that the feature is no longer available.

Run the installer with the options that you want enabled.

```
#! /bin/bash
# foreman-configure.sh
LOG_LEVEL="DEBUG"
FQDN="foreman.smurf.codes"
CERT_PATH="/etc/letsencrypt/live/$FQDN"
PRIV_KEY="$CERT_PATH/privkey.pem"
CERT="$CERT_PATH/fullchain.pem"
CHAIN="$CERT_PATH/chain.pem"
CA="/etc/ssl/certs/ca-bundle.crt"
DHCP_IP="192.168.1.1"
DHCP_LEASES="/mnt/dhcpd-db/dhcpd.leases"
DHCP_CONFIGS="/mnt/dhcpd-etc/dhcpd.conf"
OMAPI_NAME="omapi_key"
OMAPI_SECRET="mysecret"
DNS_SERVER="192.168.1.1"
TSIG_KEY="/etc/rndc.key"
foreman-installer \
  --scenario katello \
  --enable-foreman-plugin-ansible \
  --enable-foreman-plugin-remote-execution \
  --enable-foreman-plugin-tasks \
  --enable-foreman-plugin-remote-execution-cockpit \
  --enable-foreman-proxy-plugin-ansible \
  --foreman-server-ssl-chain "$CERT" \
  --foreman-server-ssl-key "$PRIV_KEY" \
  --foreman-server-ssl-cert "$CERT" \
  --foreman-server-ssl-ca "$CA" \
  --foreman-client-ssl-key "$PRIV_KEY" \
  --foreman-client-ssl-cert "$CERT" \
  --foreman-client-ssl-ca "$CA" \
  --foreman-proxy-ssl-key "$PRIV_KEY" \
  --foreman-proxy-ssl-cert "$CERT" \
  --foreman-proxy-ssl-ca "$CA" \
  --foreman-proxy-ssldir /etc/ssl/certs \
  --foreman-proxy-foreman-ssl-key "$PRIV_KEY" \
  --foreman-proxy-foreman-ssl-cert "$CERT" \
  --foreman-proxy-foreman-ssl-ca "$CA" \
  --puppet-server-foreman-ssl-key "$PRIV_KEY" \
  --puppet-server-foreman-ssl-cert "$CERT" \
  --puppet-server-foreman-ssl-ca "$CA" \
  --foreman-proxy-dhcp true \
  --foreman-proxy-dhcp-managed false \
  --foreman-proxy-dhcp-config "$DHCP_CONFIGS" \
  --foreman-proxy-dhcp-leases "$DHCP_LEASES" \
  --foreman-proxy-dhcp-server "$DHCP_IP" \
  --foreman-proxy-dns true \
  --foreman-proxy-dns-managed false \
  --foreman-proxy-dns-server "$DNS_SERVER" \
  --foreman-proxy-keyfile "$TSIG_KEY" \
  --foreman-proxy-dns-provider nsupdate \
  --foreman-proxy-plugin-dhcp-remote-isc-key-name "$OMAPI_NAME" \
  --foreman-proxy-plugin-dhcp-remote-isc-key-secret "\'$OMAPI_SECRET\'" \
  --foreman-proxy-tftp true \
  --foreman-proxy-tftp-managed true \
  --foreman-proxy-log-level "$LOG_LEVEL"

```

> **NOTE:** For network booting foreman-installer options please see the [DHCP provisioning](provisioning/dhcp.md) documentation.

#### Discovering Options

There are literally hundreds of options for `foreman-installer`. To discover them look at the `--full-help` page.

```
foreman-installer --scenario katello --full-help | less
```
## Set Certificate Permissions

> **NOTE:** Depending on your DNS provider the paths provided may change.

The `foreman-proxy` service needs permissions to read supplied certificates.

```
#! /bin/bash
# foreman-cert-permissions.md
FQDN="foreman.smurf.codes"
CERT_PATH="/etc/letsencrypt/live/$FQDN"

setfacl -R -m u:foreman:rx "$CERT_PATH/../.."
setfacl -R -m u:foreman-proxy:rx "$CERT_PATH/../.."
```

## Configure The Instance

Continue at the [configure Foreman section](quickstart.md#configure-foreman) of the Quickstart Guide to continue.
