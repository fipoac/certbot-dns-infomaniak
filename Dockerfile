FROM docker.io/certbot/certbot:latest as certbot

LABEL description="This plugin enables usage of Infomaniak public API to complete dns-01 challenges."
LABEL website="https://github.com/Infomaniak/certbot-dns-infomaniak"

ENV INFOMANIAK_API_TOKEN="" 

RUN python tools/pip_install.py --no-cache-dir certbot-dns-infomaniak
ENTRYPOINT [ "certbot", "--authenticator dns-infomaniak" ]
