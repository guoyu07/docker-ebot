FROM ubuntu:16.04 

ENV EBOT_HOME="/ebot" TIMEZONE="Europe/Berlin" PHP_VERSION="5.6.22" PTHREADS_VERSION="2.0.10"

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get clean && \
    apt-get -y install nodejs npm git wget gcc make libxml2-dev autoconf ca-certificates pkg-config && \
    apt-get clean && \
    mkdir /home/install && \
    cd /home/install && \
    wget http://de1.php.net/get/php-"${PHP_VERSION}".tar.bz2/from/this/mirror -O php-"${PHP_VERSION}".tar.bz2 && \
    tar -xjf php-"${PHP_VERSION}".tar.bz2 && \
    cd php-"${PHP_VERSION}" && \
    ./configure --prefix /usr/local --with-mysql --enable-maintainer-zts --enable-sockets --with-openssl --with-pdo-mysql && \
    make -j4 && \
    make install && \
    cd /home/install && \
    wget https://pecl.php.net/get/pthreads-"${PTHREADS_VERSION}".tgz && \
    tar -xzf pthreads-"${PTHREADS_VERSION}".tgz && \
    cd pthreads-"${PTHREADS_VERSION}" && \
    /usr/local/bin/phpize && \
    ./configure && \
    make -j4 && \
    make install && \
    echo 'date.timezone = "${TIMEZONE}"' >> /usr/local/lib/php.ini && \
    echo 'extension=pthreads.so' >> /usr/local/lib/php.ini && \
    /bin/ln -s /usr/bin/nodejs /usr/bin/node && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/bin && \
    php -r "unlink('composer-setup.php');" && \
    mkdir "$EBOT_HOME" && \
    git clone https://github.com/deStrO/eBot-CSGO.git "$EBOT_HOME" && \
    cd "$EBOT_HOME" && \
    git checkout "master" && \
    /usr/local/bin/php /usr/bin/composer.phar install && \
    npm install socket.io formidable archiver && \
    cp "$EBOT_HOME"/config/config.ini.smp "$EBOT_HOME"/config/config.ini

VOLUME ["$EBOT_HOME/demos", "$EBOT_HOME/logs"]

ADD entrypoint.sh /sbin/entrypoint.sh

EXPOSE 12360 12360/udp 12361/udp

ENTRYPOINT ["/sbin/entrypoint.sh"]
