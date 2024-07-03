FROM --platform=linux/amd64 node:20-alpine3.20 AS composerize
LABEL maintainer="alcapone1933 <alcapone1933@cosanostra-cloud.de>" \
      org.opencontainers.image.created="$(date +%Y-%m-%d\ %H:%M)" \
      org.opencontainers.image.authors="alcapone1933 <alcapone1933@cosanostra-cloud.de>" \
      org.opencontainers.image.url="https://hub.docker.com/r/alcapone1933/composerize" \
      org.opencontainers.image.ref.name="alcapone1933/composerize"
RUN  apk add --update --no-cache npm git make jq bash tini && \
     rm -rf /var/cache/apk/* && \
     mkdir -p /opt/composerize && \
     git clone https://github.com/composerize/composerize.git /opt/composerize
WORKDIR /opt/composerize/packages/composerize-website
RUN cd /opt/composerize/packages/composerize-website && \
    sed -i "s,https://www.composerize.com,/,g" /opt/composerize/packages/composerize-website/package.json && \
    sed -i "s,https://decomposerize.com,/decomposerize,g" /opt/composerize/packages/composerize-website/src/components/Entry.js && \
    sed -i "s,http://composeverter.com,/composeverter,g"  /opt/composerize/packages/composerize-website/src/components/Entry.js && \
#   npm install yarn@1.19.1 -g && \
    npm install -g serve && \
#    yarn add composerize && \
    make build
EXPOSE 80
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["serve", "-p", "80", "-s", "build"]

FROM --platform=linux/amd64 node:20-alpine3.20 AS decomposerize
LABEL maintainer="alcapone1933 <alcapone1933@cosanostra-cloud.de>" \
      org.opencontainers.image.created="$(date +%Y-%m-%d\ %H:%M)" \
      org.opencontainers.image.authors="alcapone1933 <alcapone1933@cosanostra-cloud.de>" \
      org.opencontainers.image.url="https://hub.docker.com/r/alcapone1933/composerize" \
      org.opencontainers.image.ref.name="alcapone1933/decomposerize"
RUN  apk add --update --no-cache npm git make jq bash tini && \
     rm -rf /var/cache/apk/* && \
     mkdir -p /opt/decomposerize && \
     git clone https://github.com/composerize/decomposerize.git /opt/decomposerize
WORKDIR /opt/decomposerize/packages/decomposerize-website
RUN cd /opt/decomposerize/packages/decomposerize-website && \
    sed -i "s,https://www.decomposerize.com,/decomposerize,g" /opt/decomposerize/packages/decomposerize-website/package.json && \
    sed -i "s,https://composerize.com,/,g" /opt/decomposerize/packages/decomposerize-website/src/components/Entry.js && \
    sed -i "s,http://composeverter.com,/composeverter,g"  /opt/decomposerize/packages/decomposerize-website/src/components/Entry.js && \
    npm install -g serve && \
#    yarn add decomposerize && \
    make build
EXPOSE 80
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["serve", "-p", "80", "-s", "build"]

FROM --platform=linux/amd64 node:20-alpine3.20 AS composeverter
LABEL maintainer="alcapone1933 <alcapone1933@cosanostra-cloud.de>" \
      org.opencontainers.image.created="$(date +%Y-%m-%d\ %H:%M)" \
      org.opencontainers.image.authors="alcapone1933 <alcapone1933@cosanostra-cloud.de>" \
      org.opencontainers.image.url="https://hub.docker.com/r/alcapone1933/composerize" \
      org.opencontainers.image.ref.name="alcapone1933/composeverter"
RUN  apk add --update --no-cache npm git make jq bash tini && \
     rm -rf /var/cache/apk/* && \
     mkdir -p /opt/composeverter && \
     git clone https://github.com/outilslibre/composeverter.git /opt/composeverter
WORKDIR /opt/composeverter/packages/composeverter-website
RUN cd /opt/composeverter/packages/composeverter-website && \
    sed -i "s,https://www.composeverter.com,/composeverter,g" /opt/composeverter/packages/composeverter-website/package.json && \
    sed -i "s,https://composerize.com,/,g" /opt/composeverter/packages/composeverter-website/src/components/Entry.js && \
    sed -i "s,https://decomposerize.com,/decomposerize,g"  /opt/composeverter/packages/composeverter-website/src/components/Entry.js && \
    npm install -g serve && \
    make build
EXPOSE 80
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["serve", "-p", "80", "-s", "build"]
