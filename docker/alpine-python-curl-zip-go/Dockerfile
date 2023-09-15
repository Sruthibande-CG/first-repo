FROM alpine:latest
RUN apk --update add python3 \
    && apk add make automake gcc g++ subversion python3-dev py3-pip curl zip\
    && pip3 install pyyaml
COPY --from=golang:1.13-alpine/usr/local/go/usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"
