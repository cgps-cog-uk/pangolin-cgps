FROM ubuntu:22.04

ARG VERSION=master

RUN apt update && \
    apt install -y git && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /data \
    && git clone --depth 1 --branch ${VERSION} --single-branch https://github.com/cov-lineages/pangolin-data.git \
    && mv ./pangolin-data/pangolin_data/data/* /data/

