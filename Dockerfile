FROM node:alpine3.20
WORKDIR /tmp
COPY . .
EXPOSE 3000/tcp
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    chmod +x index.js && \
    npm install && \
    mkdir -p /tmp/.tmp && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then \
        curl -L -o /tmp/.tmp/web https://arm64.ssss.nyc.mn/web && \
        curl -L -o /tmp/.tmp/bot https://arm64.ssss.nyc.mn/bot; \
    else \
        curl -L -o /tmp/.tmp/web https://amd64.ssss.nyc.mn/web && \
        curl -L -o /tmp/.tmp/bot https://amd64.ssss.nyc.mn/bot; \
    fi && \
    chmod +x /tmp/.tmp/web /tmp/.tmp/bot
CMD ["node", "index.js"]
