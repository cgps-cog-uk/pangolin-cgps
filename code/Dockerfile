ARG VERSION=master

FROM alpine:3.11.6

RUN apk add --no-cache git

RUN mkdir /code \
    && git clone https://github.com/hCoV-2019/pangolin.git \
    && cd pangolin \
    && git checkout ${VERSION} \
    && cd .. \
    && mv pangolin /code/

COPY csv_reports_to_json.py /code/

COPY entrypoint.sh /code/