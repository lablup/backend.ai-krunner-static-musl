# syntax=docker/dockerfile-upstream:1-labs
FROM alpine:3.12

ARG PREFIX=/opt/backend.ai
ARG ARCH=x86_64

ENV PATH=${PREFIX}/bin:$PATH \
    PYTHON_VERSION=3.9.6 \
    LANG=C.UTF-8

RUN apk add --no-cache \
	wget \
	tar \
	zstd \
	ca-certificates

RUN <<-EOF
    set -ex
    mkdir -p ${PREFIX}
    cd /root
    wget -O python.tar.zst "https://github.com/indygreg/python-build-standalone/releases/download/20210724/cpython-3.9.6-${ARCH}-unknown-linux-musl-noopt-20210724T1424.tar.zst"
    tar -I zstd -xC . --strip-components=1 -f python.tar.zst
    mv /root/install/* ${PREFIX}/
    mv /root/licenses ${PREFIX}/
    # aarch64 version does not have pip installed...
    ${PREFIX}/bin/python3 -m ensurepip
    rm -f python.tar.zst
EOF

RUN python3 -c 'import sys; print(sys.version_info); print(sys.prefix)'


# vim: ft=dockerfile tw=0
