# Renewing Certificates

> **NOTE** This assumes that Foreman is already installed per [the quickstart guide](quickstart.md) and certificates have already been generated via letsencrypt.

## Configure Foreman and Puppet Certificates

This changes the Apache, Katello, and Puppet certificates.

```
foreman-installer \
  --scenario katello \
  --certs-server-cert "/etc/letsencrypt/live/$HOSTNAME/fullchain.pem" \
  --certs-server-key "/etc/letsencrypt/live/$HOSTNAME/privkey.pem" \
  --certs-server-ca-cert "/etc/pki/ca-trust/source/anchors/x1-chain.pem" \
  --certs-update-server --certs-update-server-ca --certs-update-all
```
> **NOTE:** This assumes LE, depending on the CA the ca-cert may vary!

## Configure Foreman Proxy Certificates

The Foreman proxy that is automatically installed next to Foreman+Katello must have its certificates updated as well. If these certificates are not updated machines will not be able to register or report to Foreman.

> **NOTE:** This command assumes the proxy on the main foreman server is being updated. Edit the `FOREMAN_PROXY` value to reflect the proxy to update.

```
FOREMAN_PROXY=$HOSTNAME \
foreman-proxy-certs-generate --foreman-proxy-fqdn "$FOREMAN_PROXY" \
--certs-tar  "/root/$FOREMAN_PROXY-certs.tar" \
--server-cert "/etc/letsencrypt/live/$HOSTNAME/cert.pem" \
--server-key "/etc/letsencrypt/live/$HOSTNAME/privkey.pem" \
--server-ca-cert "/etc/pki/ca-trust/source/anchors/x1-chain.pem" \
 --certs-update-server
```

> **NOTE:** This assumes LE, depending on the CA the ca-cert may vary!

## Unable to find local issuer

When this error is shown the root certificate is not in the `ca-bundle.crt` bundle.

Download the root certificate (ISRG X1 in the case of LetsEncrypt) and put it in `/etc/pki/ca-trust/source/anchors` and run `update-ca-trust extract` to put it into the bundle.

## TLS Version Errors

Depending on the RHEL and Foreman+Katello version the crypto policies on the box may need to be reverted.

> **NOTE:** Only do this as a last resort. Setting crypto policies can allow insecure ciphers and TLS versions.

```
update-crypto-policies --set LEGACY
```
