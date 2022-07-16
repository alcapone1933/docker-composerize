FROM alpine:latest AS builder
LABEL maintainer="alcapone1933 alcapone1933@cosanostra-cloud.de"
RUN apk update && \
    apk upgrade && \
    apk add make && \
    apk add npm && \
    apk add git && \
    apk add jq && \
    mkdir /composerize-website && \
    mkdir /git && \
    git clone https://github.com/magicmark/composerize.git /git && \
    cp -r /git/packages/composerize-website/. /composerize-website && \
    cd /composerize-website && \
    npm install yarn@1.19.1 -g && \
    yarn add composerize && \
    make build

FROM alcapone1933/ubuntu:22.04
LABEL maintainer="alcapone1933 alcapone1933@cosanostra-cloud.de"
ENV TZ=Etc/GMT-1
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install apache2 -y && \
    rm /etc/apache2/sites-available/000-default.conf && \
    rm -r /var/www/html  && \
    rm -rf /var/lib/apt/lists/*
COPY 000-default.conf /etc/apache2/sites-available/
COPY --from=builder /composerize-website/build/* /var/www/
WORKDIR /var/www/
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
