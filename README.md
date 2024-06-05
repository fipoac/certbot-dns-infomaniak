# Dockerimage with certbot-dns-infomaniak added to certbot
This Dockerfile just adds the official [certbot-dns-infomaniak plugin](https://github.com/Infomaniak/certbot-dns-infomaniak) to the official [certbot Docker image](https://hub.docker.com/r/certbot/certbot)

## Usage example
`podman run --rm -e INFOMANIAK_API_TOKEN="YOUR-API-TOKEN-HERE" ghcr.io/fipoac/certbot-dns-infomaniak:latest --agree-tos -d domain.example.com -m your.email@example.com"`
