#!/bin/sh
set -e
echo "30 3 * * 6 certbot renew && cp -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert && cp -f /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert" | crontab -
if [ -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem ] && [ -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem ]; then
  echo "Certificate already installed"
else
  echo "Requesting certificate"
	output=$(certbot certonly -n --authenticator dns-infomaniak --cert-name $CERT_NAME "$@")
fi
if [ ! -s /cert/fullchain.pem ] || [ ! -s /cert/privkey.pem ]; then
  echo "Copying cert und key to /cert"
  CERT_PATH=$(echo "$output" | grep -o '/.*fullchain\.pem')
  echo $output
  export CERT_NAME=$(basename $(dirname $CERT_PATH))
  cp -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert
  cp -f /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert
fi
echo "Starting cron for autorenewals"
exec crond -f
