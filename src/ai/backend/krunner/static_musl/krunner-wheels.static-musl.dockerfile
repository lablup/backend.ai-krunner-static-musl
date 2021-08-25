FROM python:3.9.6-alpine

RUN apk add --no-cache \
	build-base \
	linux-headers \
	zeromq-dev \
	ca-certificates

COPY requirements.txt /root/

RUN set -ex \
    && cd /root \
    && pip wheel -w ./wheels -r requirements.txt


# vim: ft=dockerfile
