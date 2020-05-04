FROM alpine:3.11.6

ARG VERSION=master

RUN apk add --no-cache git

RUN mkdir /data \
    && git clone --branch ${VERSION} --single-branch https://github.com/hCoV-2019/lineages.git \
    && mv ./lineages/lineages/data/* /data/

