#!/bin/sh
set -e
cat << 'EOF' >> /var/spool/cron/crontabs/certbot
30 3 * * 7 certbot renew
EOF
certbot certonly --authenticator dns-infomaniak $@
echo "Copying cert und key to /cert
cp -f /etc/letsencrypt/live/$CERT_NAME/fullchain.pem /cert
cp -f /etc/letsencrypt/live/$CERT_NAME/privkey.pem /cert
echo "Starting cron for autorenewals"
exec crond -fL /var/log/cron.log
