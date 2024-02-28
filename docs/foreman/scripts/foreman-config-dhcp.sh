#! /bin/bash
# foreman-config-dhcp.sh
DHCP_IP="192.168.1.1"
DHCP_LEASES="/mnt/dhcpd-db/dhcpd.leases"
DHCP_CONFIGS="/mnt/dhcpd-etc/dhcpd.conf"
OMAPI_NAME="omapi_key"
OMAPI_SECRET="mysecret"
foreman-installer \
  Optional (for dhcp network booting) --foreman-proxy-dhcp https \
  --foreman-proxy-dhcp-config $DHCP_CONFIGS \
  --foreman-proxy-dhcp-leases $DHCP_LEASES \
  --foreman-proxy-dhcp-server $DHCP_IP \
  --foreman-proxy-plugin-dhcp-remote-isc-key-name $OMAPI_NAME \
  --foreman-proxy-plugin-dhcp-remote-isc-key-secret $OMAPI_SECRET \
  --foreman-proxy-tftp true \
  --foreman-proxy-tftp-managed true

