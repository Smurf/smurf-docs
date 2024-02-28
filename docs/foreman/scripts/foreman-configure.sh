#! /bin/bash
# foreman-configure.sh
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
  --puppet-server-foreman-ssl-ca "$CA" 

