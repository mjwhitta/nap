FROM alpine:latest

# Use bash b/c it's better
RUN apk --no-cache --update add bash && \
    rm -f -r /tmp/* /var/{cache/apk,tmp}/*
SHELL ["/bin/bash", "-c"]

# 1. Install dependencies
# 2. Install PKI tool
# 3. Clean up unnecessary files and packages
RUN set -o pipefail && \
    ( \
        apk --no-cache --update upgrade && \
        apk --no-cache --update add \
            nginx-mod-http-headers-more \
            nginx-mod-stream \
            shadow \
            sudo \
    ) && ( \
        apk --no-cache --update add go upx && \
        go install --ldflags "-s -w" --trimpath \
            github.com/mjwhitta/pki/cmd/certify@latest && \
        mv /root/go/bin/certify /usr/local/bin && \
        go install --ldflags "-s -w" --trimpath \
            github.com/mikefarah/yq/v4@latest && \
        mv /root/go/bin/yq /usr/local/bin && \
        upx /usr/local/bin/{certify,yq} \
    ) && ( \
        apk --no-cache --update del go upx && \
        rm -f -r /root/{.cache,go} /tmp/* /var/{cache/apk,tmp}/* \
    )

# Add default files
COPY root/nap/ /nap/
WORKDIR /nap

# Add scripts
ADD root/dockerentry root/start_nginx /
RUN chmod 755 /dockerentry /start_nginx

# Set entrypoint
ENTRYPOINT ["/dockerentry", "/start_nginx"]
