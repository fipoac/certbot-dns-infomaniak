#!/bin/sh
set -e
echo "30 3 * * 6 certbot renew" | crontab -
if [ -e /etc/letsencrypt/live/$CERT_NAME/fullchain.pem ] && [ -s /etc/letsencrypt/live/$CERT_NAME/fullchain.pem ]; then
  echo "Certificate already installed"
else
  echo "Requesting certificate"
	certbot certonly --authenticator dns-infomaniak --cert-name $CERT_NAME "$@"
  echo "Copying cert und key to /cert"
  cp -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert
  cp -f /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert
fi
echo "Starting cron for autorenewals"
exec crond -f
