# Google Certbot Configuration

## Install Certbot

Install certbot via pip because snap sucks.

```
sudo dnf install python3 augeas-libs

sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip install --upgrade pip

sudo /opt/certbot/bin/pip install certbot certbot-apache

# symlink to bin
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot
```

## Google Cloud DNS

> **NOTE:** Google Domains DNS **does not** support dynamic DNS updates required for TXT record based certificate issuance. If you are using a Google domain the information must be transferred over to a Google Cloud DNS zone in gcloud.

## Enable Cloud DNS

Enable the Cloud DNS from API & Services in the gcloud console.

Create the DNS zone that should have certificates managed by certbot.

## Setup gcloud cli interface

[Install gcloud cli](https://cloud.google.com/sdk/docs/install)
[Initialize the gcloud config.](https://cloud.google.com/sdk/docs/initializing)

### Create a gcloud project and enable public CA

```
gcloud projects create PROJECT_ID

gcloud config set project PROJECT_ID

gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=user:USER \
  --role=roles/publicca.externalAccountKeyCreator

gcloud services enable publicca.googleapis.com
```

### Register ACME Account

Create a HMAC and EAB and register with the public CA.

```
gcloud beta publicca external-account-keys create

certbot register \
    --email "EMAIL_ADDRESS" \
    --no-eff-email \
    --server "SERVER" \
    --eab-kid "EAB_KID" \
    --eab-hmac-key "EAB_HMAC_KEY"
```
### Create a service account

1. Open the Service accounts page.
2. Select the project created above
3. Click add Create service account.
4. Under Service account details, type a name, ID, and description for the service account, then click Create and continue.
5. Under Grant this service account access to project, select the DNS Admin IAM role.
6. Click Continue.
7. Under Grant users access to this service account, add the users or groups that are allowed to use and manage the service account.
8. Click Done.
9. Click the email of the service account just created.
10. Click the **KEYS** tab
11. Click Create key, Select JSON as the Key type then click Create.
12. Download the `.json` credentials file generated

### Request Certificate from Google CA

```
certbot certonly --dns-google --dns-google-credentials /path/to/credential.json -d DOMAIN -vv
```
