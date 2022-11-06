# Foreman Installation on Rocky Linux 8

> **Please ensure that the steps required prior to installation in the [Quickstart Guide](./quickstart.md) are adhered to.**

### Dependencies
#### Enable EPEL

```
dnf install epel-release
dnf config-manager --set-enabled powertools
```

#### Set up selinux targeted policy

```
dnf install selinux-policy-targeted -y
```

#### Enable Foreman Repo

```
# dnf localinstall https://yum.theforeman.org/releases/3.4/el8/x86_64/foreman-release.rpm
```

#### Enable Katello Repo
https://yum.theforeman.org/katello/4.6/katello/el8/x86_64/
```
# dnf localinstall https://yum.theforeman.org/katello/4.6/katello/el8/x86_64/katello-repos-latest.rpm
```

#### Enable Katello and Pulp modules

```
dnf module enable katello:el8 pulpcore:el8
```
## Generate Certificates

Generate the certificates that should be used for the Foreman install.

This guide has been done with `certbot` and Google CloudDNS. See the [certbot and Google CloudDNS documentation](../letsencrypt/google-dns.md) for details.

> **It is much easier to generate certs first then try to add them to an install.**

## Install Foreman+Katello

### Using only foreman-installer

> **NOTE:** While using lots of options may seem cumbersome I have found it to be the best way to have your install be fully reproducible. The answers file as shown below does change over versions and does not provide output that the feature is no longer available.

Run the installer with the options that you want enabled.

```
foreman-installer \
  --scenario katello \
  --enable-foreman-plugin-ansible \
  --enable-foreman-plugin-remote-execution \
  --enable-foreman-plugin-tasks \
  --enable-foreman-plugin-remote-execution-cockpit \
  --certs-server-cert "/etc/letsencrypt/live/$HOSTNAME/fullchain.pem" \
  --certs-server-key "/etc/letsencrypt/live/$HOSTNAME/privkey.pem" \
  --certs-server-ca-cert "/etc/pki/ca-trust/source/anchors/x1-chain.pem" \
  --certs-update-server --certs-update-server-ca --certs-update-all
  ```

#### Discovering Options

There are literally a hundred options for the `foreman-installer`. To discover them look at the `--full-help` page.

```
foreman-installer --scenario katello --full-help | less
```

### Using an answers file

> **NOTE:** From personal experience I do not reccomend this. During upgrades there will be cryptic error messages that occur during install due to changes to the possible answers. See [Using only foreman-installer](#using-only-foreman-installer) for a preferred method.

Create a copy of the `katello-answers.yaml` file.

`cp /etc/foreman-installer/scenarios.d/katello-answers.yaml /etc/foreman-installer/katello-answers.yaml`

Point `katello.yaml` to the custom answers file.

`vim /etc/foreman-installer/scenarios.d/katello.yaml`

Edit the custom answers file

`$ vim /etc/foreman-installer/katello-answers.yaml`

> **My custom answers file:** [katello-answers.yaml](./katello-answers.yaml)

```
foreman-installer --scenario katello \
  --enable-foreman-plugin-ansible --enable-foreman-plugin-remote-execution --enable-foreman-plugin-tasks \
  --enable-foreman-proxy-plugin-ansible \
  --certs-server-cert "/etc/letsencrypt/live/$HOSTNAME/fullchain.pem" \
  --certs-server-key "/etc/letsencrypt/live/$HOSTNAME/privkey.pem" \
  --certs-server-ca-cert "/etc/pki/ca-trust/source/anchors/x1-chain.pem" \
  --certs-update-server --certs-update-server-ca --certs-update-all
``` 

## Run the Installer

`$ foreman-installer --scenario katello`

## Configure The Instance

See the [configuration documentation](configuration.md) for details on getting started.
