# Troubleshooting

# Assessing overall health

Foreman has a few tools to asess the health of the instance and/or proxy.

### Services Status

`foreman-maintain service status`

### Smart Proxy Health

In the foreman web UI navigate to Infrastructure > Smart Proxies. The health of all proxies will be shown.

### Logs

Foreman and the foreman-proxy log to `/var/log/foreman/` and `/var/log/foreman-proxy/` respectively.

## Cockpit

### Enable web console job not enabling cockpit

This can happen when dependencies in the RPM for the `cockpit-system` package do not get installed. To fix this run a one off job on the affected host to install `cockpit` and `cockpit-ws`

> **That didn't work!!!** 
> If the above doesn't work force a one off job that **reinstalls** the packages with `dnf reinstall`.

### I keep getting a blue "Try Again" when trying to enter the web console

This can be due to the foreman installer configuring the cockpit plugin with the incorrect certificates.

You can configure the certificates used for the cockpit web console by editing `/etc/foreman/cockpit/foreman-cockpit-session.yml` **on the foreman instance**.

> **Troubleshooting steps:** 
>    1. SSH into the affected host
>    2. `journalctl -xe` and search for `foreman-cockpit-settings`. 
>    3. If a `certificate verify fail` error is occuring confirm that the correct certificates are being used in the log message directly above the error.
>    4. Confirm the correct certificates are used in the file `/etc/foreman/cockpit/foreman-cockpit-session.yml` on the foreman instance.

