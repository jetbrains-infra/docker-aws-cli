FROM tbrock/saw:v0.2.0 as saw

FROM alpine:latest
COPY --from=saw /bin/saw /bin/saw

ENV AWS_CLI_VERSION 1.16.268

RUN apk --no-cache update && \
    apk --no-cache add python3 less bash jq curl && \
    pip3 --no-cache-dir install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/run/aws
COPY entrypoint.sh /entrypoint.sh
WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
