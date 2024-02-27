# Using Certbot with Cloudflare

Thankfully using certbot with cloudflare is far easier than Google Cloud DNS.

## Install Certbot

Install certbot via pip because snap sucks.

```
sudo dnf install python3 augeas-libs -y

sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip install --upgrade pip

sudo /opt/certbot/bin/pip install certbot certbot-dns-cloudflare pyOpenSSL==23.1.1 #Fixes bug with older openssl on rocky 8

# symlink to bin
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot
```

## Create a Cloudflare API token

Use the **Create Token** wizard on the [Cloudflare API Token Dashboard](https://dash.cloudflare.com/profile/api-tokens).

## Configure cloudflare.ini

In a secure place create a `cloudflare.ini` file.

```
# /root/cloudflare.ini
dns_cloudflare_api_token = adsljkasdjklasdfl;kjasdklj
```

Make the file immutable.
```
chattr +i /root/cloudflare.ini
```

## Ensure R3 authority is trusted (Required on RHEL <=8)

```
cd /etc/pki/ca-trust/source/anchors
curl https://letsencrypt.org/certs/lets-encrypt-r3.pem -o le-r3.pem
update-ca-trust
```

## Issue a Certificate

```
certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /root/cloudflare.ini \
  -d example.com
```
