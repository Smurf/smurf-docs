# Foreman Quickstart

Foreman requires quite a bit of configuration before the first machine can be registered and update against it.

# Setup SSL Certificates

1. [Generate the SSL Certificates]
    - [Google Cloud DNS](../letsencrypt/google-dns.md)
    - [Cloudflare](../letsencrypt/cloudflare.md)
    - If another DNS provider used follow the instructions provided by Certbot and/or the DNS provider.
2. [Renew the SSL Certificates](cert-renew.md)
    - Ensure the paths referenced in these commands are correct.

# Install Foreman

Follow the [Foreman Installation Guide](./install.md) for Rocky 8.

# Configure Foreman

Foreman requires quite a bit of configuration to be useful. This guide may miss some steps.

### Set Certificate Permissions

`foreman-proxy` needs permissions to read supplied certificates.

```
FQDN="foreman.smurf.codes"
CERT_PATH="/etc/letsencrypt/live/$FQDN"

setfacl -R -m u:foreman:rx "$CERT_PATH/../.."
```

### Increase Sync Timeout

Increasing the sync timeout will prevent large packages from causing the repo sync to fail.

Administer > settings > Content > Sync Connection Timeout > 600 Seconds

### Add Rocky Product

Create a new product with the name "Rocky 9"

### Add Repositories

1. [Rocky 9](repos/rocky9.md)
2. [Rocky 9 AppStream](repos/rocky9-appstream.md)
2. [Rocky 9 Extras (required for epel)](repos/rocky9-appstream.md)

### Add Content Views


