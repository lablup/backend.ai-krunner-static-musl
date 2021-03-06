FROM alpine:3.12

ARG PREFIX=/opt/backend.ai

ENV PATH=${PREFIX}/bin:$PATH \
    PYTHON_VERSION=3.8.6 \
    LANG=C.UTF-8

RUN apk add --no-cache \
	wget \
	tar \
	zstd \
	ca-certificates

# For local build & testing:
# COPY cpython-3.8.6-x86_64-unknown-linux-musl-noopt-testing.tar.zst /root/python.tar.zst

RUN set -ex \
    && mkdir -p ${PREFIX} \
    && cd /root \
    && wget -O python.tar.zst "https://github.com/indygreg/python-build-standalone/releases/download/20201020/cpython-3.8.6-x86_64-unknown-linux-musl-noopt-20201020T0627.tar.zst" \
    && tar -I zstd -xC . --strip-components=1 -f python.tar.zst \
    && mv /root/install/* ${PREFIX}/ \
    && mv /root/licenses ${PREFIX}/ \
    && rm -f python.tar.zst

RUN python3 -c 'import sys; print(sys.version_info); print(sys.prefix)'


# vim: ft=dockerfile tw=0
