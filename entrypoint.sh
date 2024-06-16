#!/bin/sh
set -e
if [ -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem ] && [ -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem ]; then
  echo "Certificate already installed"
else
  echo "Requesting certificate"
	output=$(certbot certonly -n --authenticator dns-infomaniak --cert-name $CERT_NAME "$@")
  CERT_PATH=$(echo "$output" | grep -o '/.*fullchain\.pem')
  export CERT_NAME=$(basename $(dirname $CERT_PATH))
  echo $output
fi
if [ ! -s /cert/fullchain.pem ] || [ ! -s /cert/privkey.pem ]; then
  echo "Copying cert und key to /cert"
  cp /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert
  if [ $? != 0 ]; then
    echo "Tried to copy fullchain.pem: $? - Unsuccessful"
  fi
  cp /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert
  if [ $? != 0 ]; then
    echo "Tried to copy privkey.pem: $? - Unsuccessful"
  fi
fi
echo "Creating crontab"
echo "30 3 * * 6 certbot renew && cp -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert && cp -f /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert" | crontab -
echo "Starting cron for autorenewals"
exec crond -f
