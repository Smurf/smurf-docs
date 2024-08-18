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

