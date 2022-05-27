FROM ubuntu:22.04

ARG VERSION=master

RUN apt update && \
    apt install -y git && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /code \
    && git clone --depth 1 --branch ${VERSION} --single-branch https://github.com/cov-lineages/pangolin.git \
    && mv pangolin /code/

COPY csv_reports_to_json.py /code/

COPY entrypoint.sh /code/