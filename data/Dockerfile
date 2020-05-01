ARG VERSION=master

FROM alpine:3.11.6

RUN apk add --no-cache git

RUN mkdir /data \
    && git clone https://github.com/hCoV-2019/lineages.git \
    && cd lineages \
    && git checkout ${VERSION} \
    && cd .. \
    && mv ./lineages/lineages/data/* /data/

