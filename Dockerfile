FROM alcapone1933/ubuntu:22.04 AS builder
LABEL maintainer="alcapone1933 alcapone1933@cosanostra-cloud.de"
RUN apt-get update && \
    apt-get -y install \
    git jq make npm # apache2 && \
    # rm /etc/apache2/sites-available/000-default.conf && \
    # rm -r /var/www/html  && \	
    mkdir /composerize-website && \
    mkdir /git && \
    git clone https://github.com/magicmark/composerize.git /git && \
    cp -r /git/packages/composerize-website/. /composerize-website && \
    cd /composerize-website && \
    npm install yarn@1.19.1 -g && \
    yarn add composerize && \
    make build
    # cp -r /composerize-website/build/* /var/www/ && \
    # rm -rf /composerize-website && \
    # rm -rf /git && \
    # rm -rf /var/lib/apt/lists/*
# COPY 000-default.conf /etc/apache2/sites-available/
# WORKDIR /var/www/
# EXPOSE 80
# CMD ["apache2ctl","-D","FOREGROUND"]

FROM alcapone1933/ubuntu:22.04
LABEL maintainer="alcapone1933 alcapone1933@cosanostra-cloud.de"
ENV TZ=Europe/Berlin
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
