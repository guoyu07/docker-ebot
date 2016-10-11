FROM php:5.6.25-zts

ENV EBOT_HOME="/ebot" EBOT_VERSION="dev" TIMEZONE="Europe/Berlin" PTHREADS_VERSION="2.0.10"

RUN apt-get update && \
    apt-get install -y git nodejs npm && \
    apt-get clean && \
    mkdir ${EBOT_HOME} && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install socket.io@0.9.12 archiver formidable && \
    npm install -g forever && \
    pecl install "pthreads-${PTHREADS_VERSION}" && \
    docker-php-ext-enable pthreads && \
    docker-php-ext-install mysql sockets && \
    echo "date.timezone = ${TIMEZONE}" >> /usr/local/etc/php/conf.d/php.ini && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/bin && \
    php -r "unlink('composer-setup.php');" && \
    git clone https://github.com/carazzim0/eBot-CSGO.git "$EBOT_HOME" && \
    cd "$EBOT_HOME" && git checkout "$EBOT_VERSION" && \
    /usr/local/bin/php /usr/bin/composer.phar install && \
    cp "$EBOT_HOME"/config/config.ini.smp "$EBOT_HOME"/config/config.ini

VOLUME ["$EBOT_HOME/demos", "$EBOT_HOME/logs"]

COPY entrypoint.sh /sbin/entrypoint.sh

EXPOSE 12360 12360/udp 12361/udp

ENTRYPOINT ["/sbin/entrypoint.sh"]
