# Nginx App Proxy (NAP)

[![Yum](https://img.shields.io/badge/-Buy%20me%20a%20cookie-blue?labelColor=grey&logo=cookiecutter&style=for-the-badge)](https://www.buymeacoffee.com/mjwhitta)

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/mjwhitta/nap/container.yaml?style=for-the-badge)](https://github.com/mjwhitta/nap/actions)
![License](https://img.shields.io/github/license/mjwhitta/nap?style=for-the-badge)

Tired of dealing with bloated and/or complicated reverse proxy
solutions? Sounds like you could use a NAP!

## Why?

I loved [SWAG] but eventually decided I didn't need Let's Encrypt for
my home lab, so I switched to [NPM]. For a while things were fine.
Unfortunately I looked at the size of those containers and realized
that I didn't need ~500MB or ~950MB to simply redirect to my other
self-hosted services.

Thus, Nginx App Proxy (NAP) was born! This container is ~20MB and has
support for you bringing your own certs (BYOC), whether that be
self-signed, Let's Encrypt, or even Let's Encrypt wildcard certs. How
you refresh your certs is up to you. This container just provides
Nginx reverse proxy capabilities. Nothing fancy, unless you count the
navigation dashboard (navdash).

[NPM]: https://nginxproxymanager.com
[SWAG]: https://github.com/linuxserver/docker-swag

## Usage

The [default config](./root/nap/data/config.yaml) is fairly well
documented. You should also look at [compose.yaml](./compose.yaml) for
an example Docker compose file. Finally, [examples](./examples) has
some config examples for specific use cases.

You can pull the container with `docker pull
ghcr.io/mjwhitta/nap:latest` or build it locally with `./build`.
