FROM alpine:latest

# Use bash b/c it's better
RUN apk --no-cache --update add bash && \
    rm -f -r /tmp/* /var/{cache/apk,tmp}/*
SHELL ["/bin/bash", "-c"]

# Add default files
COPY root /

# 1. Install dependencies
# 2. Install PKI tool and YAML to JSON tool
# 3. Fix permissions
# 4. Clean up unnecessary files and packages
RUN set -o pipefail && \
    ( \
        apk --no-cache --update upgrade && \
        apk --no-cache --update add \
            git \
            go \
            jq \
            nginx-mod-http-headers-more \
            nginx-mod-stream \
            shadow \
            sudo \
            upx \
    ) && ( \
        go install --buildvcs=false --ldflags="-s -w" --trimpath \
            github.com/mjwhitta/pki/cmd/certify@latest && \
        mv /root/go/bin/certify /usr/local/bin && \
        cd /yaml2json && \
        go build --buildvcs=false --ldflags="-s -w" \
            -o /usr/local/bin/y2j --trimpath . && \
        upx /usr/local/bin/{certify,y2j} \
    ) && ( \
        chmod u=rwx,go=rx /dockerentry /start_nginx /usr/local/bin/* \
    ) && ( \
        rm -f -r /yaml2json && \
        apk --no-cache --update del git go upx && \
        rm -f -r /root/{.cache,go} /tmp/* /var/{cache/apk,tmp}/* \
    )

WORKDIR /nap

# Set entrypoint
ENTRYPOINT ["/dockerentry", "/start_nginx"]
