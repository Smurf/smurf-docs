# Renewing Certificates

> **NOTE** This assumes that foreman is already configured and certificates have already been generated via letsencrypt.

```
foreman-installer \
  --scenario katello \
  --foreman-server-ssl-cert /etc/letsencrypt/live/$HOSTNAME/cert.pem \
  --foreman-server-ssl-chain /etc/letsencrypt/live/$HOSTNAME/fullchain.pem \
  --foreman-server-ssl-key /etc/letsencrypt/live/$HOSTNAME/privkey.pem \
  --foreman-proxy-foreman-ssl-ca /etc/ssl/certs/ca-bundle.crt \
  --puppet-server-foreman-ssl-ca /etc/ssl/certs/ca-bundle.crt \
  --certs-server-cert "/etc/letsencrypt/live/$HOSTNAME/cert.pem" \
  --certs-server-key "/etc/letsencrypt/live/$HOSTNAME/privkey.pem" \
  --certs-server-ca-cert "/etc/ssl/certs/ca-bundle.crt" \
  --certs-update-server --certs-update-server-ca
```

> **NOTE:** This may warn about the size of `ca-bundle.crt`. This warning can safely be ignored.

```
export FOREMAN_PROXY=$HOSTNAME #EDIT TO MATCH YOUR PROXY HOSTNAME
foreman-proxy-certs-generate --foreman-proxy-fqdn "$FOREMAN_PROXY" \
--certs-tar  "~/$FOREMAN_PROXY-certs.tar" \
--server-cert "/etc/letsencrypt/live/$HOSTNAME/cert.pem" \
--server-key "/etc/letsencrypt/live/$HOSTNAME/privkey.pem" \
--server-ca-cert "/etc/ssl/certs/ca-bundle.crt" \
--certs-regenerate --certs-update-server
```

> **NOTE:** This command assumes the proxy on the main foreman server is being updated. Edit the `FOREMAN_PROXY` value to reflect the proxy to update.

## Unable to find local issuer

When this error is shown the root certificate is not in the `ca-bundle.crt` bundle.

Download the root certificate (ISRG X1 in the case of LetsEncrypt) and put it in `/etc/pki/ca-trust/source/anchors` and run `update-ca-trust extract` to put it into the bundle.

## TLS Version Errors

Depending on the RHEL and Foreman+Katello version the crypto policies on the box may need to be reverted.

> **NOTE:** Only do this as a last resort. Setting crypto policies can allow insecure ciphers and TLS versions.

```
update-crypto-policies --set LEGACY
```
