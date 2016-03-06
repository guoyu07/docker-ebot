FROM debian:jessie

ENV ebothome="<ebot-directory>" ebotip="<ebotip>"

RUN \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get clean && \
	apt-get -y install nodejs npm curl git php5-cli php5-mysql screen unzip && \
	apt-get clean && \
	sed -i 's/;date.timezone =/date.timezone = Europe\/Berlin/g' /etc/php5/cli/php.ini && \
	/bin/ln -s /usr/bin/nodejs /usr/bin/node

RUN \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin

#install ebot
RUN \
	mkdir ${ebothome} && \
	curl -L https://github.com/deStrO/eBot-CSGO/archive/master.zip  >> ${ebothome}/master.zip && \
	unzip -d ${ebothome} ${ebothome}/master.zip && \
	mv ${ebothome}/eBot-CSGO-master/* ${ebothome} && \
	rm -rf ${ebothome}/eBot-CSGO-master && \
	cd ${ebothome} && \
	/usr/bin/php /usr/bin/composer.phar install

#npm shit
RUN npm install socket.io formidable archiver

EXPOSE 12360 12361

COPY Match.php ${ebothome}/src/eBot/Match/Match.php

ADD entrypoint.sh /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["<EBOT_HOMEFOLDER_HERE>", "<EBOT_IP_HERE"]
