FROM python:3.8.6-alpine

RUN apk add --no-cache \
	build-base \
	linux-headers \
	ca-certificates

COPY requirements.txt /root/

RUN set -ex \
    && cd /root \
    && pip wheel -w ./wheels -r requirements.txt


# vim: ft=dockerfile
