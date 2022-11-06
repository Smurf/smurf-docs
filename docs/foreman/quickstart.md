# Foreman Quickstart

Foreman requires quite a bit of configuration before the first machine can be registered and update against it.

## Setup SSL Certificates

1. [Generate the SSL Certificates](../letsencrypt/google-dns.md)
    - If Google Cloud DNS is not used follow the instructions provided by Certbot and/or the DNS provider.
2. [Renew the SSL Certificates](cert-renew.md)
    - Ensure the paths referenced in these commands are correct.

## Install Foreman

1. [Foreman Installation Guide](./install.md)

## Increase Sync Timeout

Increasing the sync timeout will prevent large packages from causing the repo sync to fail.

Administer > settings > Content > Sync Connection Timeout > 600 Seconds

## Add Rawhide Product

Create a new product with the name "Rawhide"

## Add Repositories

1. [Fedora Rawhide](repos/rawhide-repo.md)
2. [RPMFusion Free and Nonfree](repos/rpmfusion.md)
3. [Vanilla Kernel](repos/vanilla-kernel.md)

## Provisioning Setup

Even if not kickstarting these values are required for registration of devices.

### Installation Media

Create new medium because rawhide has a different URL pattern than mainline Feodra or RHEL releases.

- Name: Rawhide mirror
- `https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Everything/$arch/os/`
- OS Family: Redhat

### Operating Systems

- Name: Fedora-Rawhide-38
- Major Version: 38
- Family: Redhat
- Parition Table: Kickstart Default
- Installation Media: Rawhide mirror
