FROM --platform=linux/amd64 node:23-alpine3.21 AS composerize
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
#   npm install -g serve && \
#   yarn add composerize && \
    make build
EXPOSE 80
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["serve", "-p", "80", "-s", "build"]

FROM --platform=linux/amd64 node:23-alpine3.21 AS decomposerize
RUN  apk add --update --no-cache npm git make jq bash tini && \
     rm -rf /var/cache/apk/* && \
     mkdir -p /opt/decomposerize && \
     git clone https://github.com/composerize/decomposerize.git /opt/decomposerize
WORKDIR /opt/decomposerize/packages/decomposerize-website
RUN cd /opt/decomposerize/packages/decomposerize-website && \
    sed -i "s,https://www.decomposerize.com,/decomposerize,g" /opt/decomposerize/packages/decomposerize-website/package.json && \
    sed -i "s,https://composerize.com,/,g" /opt/decomposerize/packages/decomposerize-website/src/components/Entry.js && \
    sed -i "s,http://composeverter.com,/composeverter,g"  /opt/decomposerize/packages/decomposerize-website/src/components/Entry.js && \
#   npm install -g serve && \
#   yarn add decomposerize && \
    make build
# EXPOSE 80
# ENTRYPOINT ["/sbin/tini", "--"]
# CMD ["serve", "-p", "80", "-s", "build"]

FROM --platform=linux/amd64 node:23-alpine3.21 AS composeverter
RUN  apk add --update --no-cache npm git make jq bash tini && \
     rm -rf /var/cache/apk/* && \
     mkdir -p /opt/composeverter && \
     git clone https://github.com/outilslibre/composeverter.git /opt/composeverter
WORKDIR /opt/composeverter/packages/composeverter-website
RUN cd /opt/composeverter/packages/composeverter-website && \
    sed -i "s,https://www.composeverter.com,/composeverter,g" /opt/composeverter/packages/composeverter-website/package.json && \
    sed -i "s,https://composerize.com,/,g" /opt/composeverter/packages/composeverter-website/src/components/Entry.js && \
    sed -i "s,https://decomposerize.com,/decomposerize,g"  /opt/composeverter/packages/composeverter-website/src/components/Entry.js && \
#    npm install -g serve && \
    make build
# EXPOSE 80
# ENTRYPOINT ["/sbin/tini", "--"]
# CMD ["serve", "-p", "80", "-s", "build"]

FROM --platform=linux/amd64 alcapone1933/ubuntu:22.04
LABEL maintainer="alcapone1933 <alcapone1933@cosanostra-cloud.de>" \
      org.opencontainers.image.created="$(date +%Y-%m-%d\ %H:%M)" \
      org.opencontainers.image.authors="alcapone1933 <alcapone1933@cosanostra-cloud.de>" \
      org.opencontainers.image.url="https://hub.docker.com/r/alcapone1933/composerize" \
      org.opencontainers.image.ref.name="alcapone1933/composerize"
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get -y install apache2 && \
    rm /etc/apache2/sites-available/000-default.conf && \
    rm -r /var/www/html  && \
    rm -rf /var/lib/apt/lists/*  && \
    mkdir -p /var/www/decomposerize /var/www/composeverter
COPY 000-default.conf /etc/apache2/sites-available/
COPY --from=composerize /opt/composerize/packages/composerize-website/build/ /var/www/
COPY --from=decomposerize /opt/decomposerize/packages/decomposerize-website/build/ /var/www/decomposerize/
COPY --from=composeverter /opt/composeverter/packages/composeverter-website/build/ /var/www/composeverter/
RUN cd /var/www && tar cfvz /opt/composerize.tar.gz * && \
    echo "ServerName default" > /etc/apache2/conf-available/servername.conf && \
    a2enconf servername.conf
WORKDIR /var/www/
EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["apache2ctl","-D","FOREGROUND"]
