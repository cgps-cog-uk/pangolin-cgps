FROM alpine:3.11.6

ARG VERSION=master

RUN apk add --no-cache git

RUN mkdir /code \
    && git clone --branch ${VERSION} --single-branch https://github.com/cov-lineages/pangolin.git \
    && mv pangolin /code/

COPY csv_reports_to_json.py /code/

COPY entrypoint.sh /code/