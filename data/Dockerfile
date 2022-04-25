FROM alpine:3.11.6

ARG VERSION=master

RUN apk add --no-cache git

RUN mkdir /data \
    && git clone --depth 1 --branch ${VERSION} --single-branch https://github.com/cov-lineages/pangolin-data.git \
    && mv ./pangolin-data/pangolin_data/data/* /data/

