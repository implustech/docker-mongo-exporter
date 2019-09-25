FROM golang:1.13

ENV VERSION 0.10.0

WORKDIR /tmp

RUN  git clone https://github.com/percona/mongodb_exporter &&\
     cd mongodb_exporter && git checkout $VERSION && \
     make build 

FROM alpine:latest

RUN mkdir /app

WORKDIR /app

COPY --from=0 /tmp/mongodb_exporter/bin/mongodb_exporter /app/mongodb_exporter

ENTRYPOINT [ "/app/mongodb_exporter" ]

