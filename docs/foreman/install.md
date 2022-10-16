# Foreman Installation on Rocky Linux 8

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

## Customizing answers file

Create a copy of the `katello-answers.yaml` file.

`cp /etc/foreman-installer/scenarios.d/katello-answers.yaml /etc/foreman-installer/katello-answers.yaml`

Point `katello.yaml` to the custom answers file.

`vim /etc/foreman-installer/scenarios.d/katello.yaml`

Edit the custom answers file

`$ vim /etc/foreman-installer/katello-answers.yaml`

> **My custom answers file:** [katello-answers.yaml](./katello-answers.yaml)

## Run the Installer

`$ foreman-installer --scenario katello`

## Configure The Instance

See the [configuration documentation](configuration.md) for details on getting started.
