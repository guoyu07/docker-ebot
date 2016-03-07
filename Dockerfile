FROM debian:jessie

ENV EBOT_HOME="/ebot" TIMEZONE="Europe/Berlin"

ADD entrypoint.sh /sbin/entrypoint.sh

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get clean && \
    apt-get -y install nodejs npm curl git php5-cli php5-mysql screen git && \
    apt-get clean && \
    sed -i "s~;date.timezone =~date.timezone = $TIMEZONE~g" /etc/php5/cli/php.ini && \
    /bin/ln -s /usr/bin/nodejs /usr/bin/node && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin && \
    mkdir "$EBOT_HOME" && \
    git clone https://github.com/deStrO/eBot-CSGO.git . && \    
    cd "$EBOT_HOME" && \
    /usr/bin/php /usr/bin/composer.phar install && \
    npm install socket.io formidable archiver

COPY Match.php ${EBOT_HOME}/src/eBot/Match/Match.php

EXPOSE 12360 12361

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["$EBOT_HOME"]
