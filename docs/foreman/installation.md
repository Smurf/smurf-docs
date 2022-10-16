# Foreman Notes for Rocky Linux 8

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

### Enable Katello and Pulp modules

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

[katello-answers.yaml](./katello-answers.yaml)

`$ foreman-installer --scenario katello`

# Rawhide Repo Addition

### Increase Sync Timeout

Administer > settings > Content > Sync Connection Timeout

### Content Credentials (GPG Key)

```
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBGAcScoBEADLf8YHkezJ6adlMYw7aGGIlJalt8Jj2x/B2K+hIfIuxGtpVj7e
LRgDU76jaT5pVD5mFMJ3pkeneR/cTmqqQkNyQshX2oQXwEzUSb1CNMCfCGgkX8Q2
zZkrIcCrF0Q2wrKblaudhU+iVanADsm18YEqsb5AU37dtUrM3QYdWg9R+XiPfV8R
KBjT03vVBOdMSsY39LaCn6Ip1Ovp8IEo/IeEVY1qmCOPAaK0bJH3ufg4Cueks+TS
wQWTeCLxuZL6OMXoOPKwvMQfxbg1XD8vuZ0Ktj/cNH2xau0xmsAu9HJpekvOPRxl
yqtjyZfroVieFypwZgvQwtnnM8/gSEu/JVTrY052mEUT7Ccb74kcHFTFfMklnkG/
0fU4ARa504H3xj0ktbe3vKcPXoPOuKBVsHSv00UGYAyPeuy+87cU/YEhM7k3SVKj
6eIZgyiMO0wl1YGDRKculwks9A+ulkg1oTb4s3zmZvP07GoTxW42jaK5WS+NhZee
860XoVhbc1KpS+jfZojsrEtZ8PbUZ+YvF8RprdWArjHbJk2JpRKAxThxsQAsBhG1
0Lux2WaMB0g2I5PcMdJ/cqjo08ccrjBXuixWri5iu9MXp8qT/fSzNmsdIgn8/qZK
i8Qulfu77uqhW/wt2btnitgRsqjhxMujYU4Zb4hktF8hKU/XX742qhL5KwARAQAB
tDFGZWRvcmEgKDM1KSA8ZmVkb3JhLTM1LXByaW1hcnlAZmVkb3JhcHJvamVjdC5v
cmc+iQJOBBMBCAA4FiEEeH6mrhFH7uVsQLMM20Y5cZhnxY8FAmAcScoCGw8FCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQ20Y5cZhnxY+NYA/7BYpglySAZYHhjyKh
/+f6zPfVvbH20Eq3kI7OFBN0nLX+BU1muvS+qTuS3WLrB3m3GultpKREJKLtm5ED
1rGzXAoT1yp9YI8LADdMCCOyjAjsoWU87YUuC+/bnjrTeR2LROCfyPC76W985iOV
m5S+bsQDw7C2LrldAM4MDuoyZ1SitGaZ4KQLVt+TEa14isYSGCjzo7PY8V3JOk50
gqWg82N/bm2EzS7T83WEDb1lvj4IlvxgIqKeg11zXYxmrYSZJJCfvzf+lNS6uxgH
jx/J0ylZ2LibGr6GAAyO9UWrAZSwSM0EcjT8wECnxkSDuyqmWwVvNBXuEIV8Oe3Y
MiU1fJN8sd7DpsFx5M+XdnMnQS+HrjTPKD3mWrlAdnEThdYV8jZkpWhDys3/99eO
hk0rLny0jNwkauf/iU8Oc6XvMkjLRMJg5U9VKyJuWWtzwXnjMN5WRFBqK4sZomMM
ftbTH1+5ybRW/A3vBbaxRW2t7UzNjczekSZEiaLN9L/HcJCIR1QF8682DdAlEF9d
k2gQiYSQAaaJ0JJAzHvRkRJLLgK2YQYiHNVy2t3JyFfsram5wSCWOfhPeIyLBTZJ
vrpNlPbefsT957Tf2BNIugzZrC5VxDSKkZgRh1VGvSIQnCyzkQy6EU2qPpiW59G/
hPIXZrKocK3KLS9/izJQTRltjMA=
=PfT7
-----END PGP PUBLIC KEY BLOCK-----
```



### Repo Mirror

`http://iad.mirror.rackspace.com/fedora/development/rawhide/Everything/x86_64/os/`

# RPM Fusion Repo

#### Keys

https://rpmfusion.org/keys

#### Repo Mirror
```
http://mirror.math.princeton.edu/pub/rpmfusion/nonfree/fedora/development/rawhide/Everything/x86_64/os/
http://mirror.math.princeton.edu/pub/rpmfusion/free/fedora/development/rawhide/Everything/x86_64/os/
```

# Provisioning

### Installation Media

Create new medium because rawhide has a different URL pattern.

Name: Rawhide mirror

`https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Everything/$arch/os/`

OS Family: Redhat

# Operating Systems

Name: Fedora-Rawhide-38

Major Version: 38
Family: Redhat
Parition Table: Kickstart Default
Installation Media: Rawhide mirror