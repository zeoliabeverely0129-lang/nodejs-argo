FROM node:alpine3.22
WORKDIR /tmp
COPY index.js package.json ./
EXPOSE 3000/tcp
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    chmod +x index.js && \
    npm install && \
    mkdir -p /assets && \
    curl -L --retry 3 -o /assets/web_amd64 https://amd64.ssss.nyc.mn/web && \
    curl -L --retry 3 -o /assets/bot_amd64 https://amd64.ssss.nyc.mn/bot && \
    curl -L --retry 3 -o /assets/web_arm64 https://arm64.ssss.nyc.mn/web && \
    curl -L --retry 3 -o /assets/bot_arm64 https://arm64.ssss.nyc.mn/bot && \
    chmod +x /assets/web_amd64 /assets/bot_amd64 /assets/web_arm64 /assets/bot_arm64
CMD ["node", "index.js"]
