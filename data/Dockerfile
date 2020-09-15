FROM alpine:3.11.6

ARG VERSION=master

RUN apk add --no-cache git

RUN mkdir /data \
    && git clone --branch ${VERSION} --single-branch https://github.com/cov-lineages/pangoLEARN.git \
    && mv ./pangoLEARN/pangoLEARN/data/* /data/

