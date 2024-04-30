# Creating a RW NFS Share in OpnSense

## Configure rc.conf

Add these lines to `/etc/rc.conf`

```
nfs_server_enable="YES"
nfs_server_flags="-u -t -n 4"
mountd_flags="-r"
mountd_enable="YES"
rpcbind_enable="YES"
rpc_statd_enable="YES"
rpc_lockd_enable="YES"
```

## Configure hardlinks

Symlinks cannot be used, it must be a hardlink.

```
mkdir -p /exports/var/dhcpd/var
mkdir -p /exports/var/dhcpd/etc
ln -l /var/dhcpd/var/db /exports/var/dhcpd/var/db
ln -l /var/dhcpd/etc /exports/var/dhcpd/etc
```

## Edit the `/etc/exports` file

```
/exports/var/dhcpd/etc -maproot=root -alldirs -network 192.168.1.0 -mask 255.255.255.0
/exports/var/dhcpd/var/db -maproot=root -alldirs -network 192.168.1.0 -mask 255.255.255.0
```
