#!/bin/sh
set -e
echo "30 3 * * 6 certbot renew" | crontab -
certbot certonly --authenticator dns-infomaniak --cert-name $CERT_NAME "$@"
echo "Copying cert und key to /cert"
cp -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert
cp -f /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert
echo "Starting cron for autorenewals"
exec crond -f
