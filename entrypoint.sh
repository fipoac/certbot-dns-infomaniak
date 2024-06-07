#!/bin/sh
set -e
# echo "30 3 * * 6 certbot renew && cp -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert && cp -f /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert" | crontab -
# if [ -e /etc/letsencrypt/live/$CERT_NAME/fullchain.pem ] && [ -s /etc/letsencrypt/live/$CERT_NAME/fullchain.pem ]; then
#   echo "Certificate already installed"
# else
#   echo "Requesting certificate"
# 	output=$(certbot certonly --authenticator dns-infomaniak --cert-name $CERT_NAME "$@")
#   echo "Copying cert und key to /cert"
#   CERT_PATH=$(echo "$output" | grep -o '/.*fullchain\.pem')
#   echo $output
#   export CERT_NAME=$(basename $(dirname $CERT_PATH))
#   cp -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert
#   cp -f /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert
# fi
# echo "Starting cron for autorenewals"
# exec crond -f
wget https://acme-v02.api.letsencrypt.org/directory
echo directory
