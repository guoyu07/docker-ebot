FROM debian:jessie

ENV ebothome="<ebot-directory>" ebotip="<ebotip>" mysqluser="<mysqluser>" mysqlpw="<mysqlpw>" mysqldb="<mysqldb>"

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

#configure ebot
RUN \
	sed -i "s/MYSQL_USER = \"ebotv3\"/MYSQL_USER = \"$mysqluser\"/g" ${ebothome}/config/config.ini && \
	sed -i "s/MYSQL_PASS = \"ebotv3\"/MYSQL_PASS = \"$mysqlpw\"/g" ${ebothome}/config/config.ini && \
	sed -i "s/MYSQL_BASE = \"ebotv3\"/MYSQL_BASE = \"$mysqldb\"/g" ${ebothome}/config/config.ini && \
	sed -i "s/BOT_IP = \"127.0.0.1\"/BOT_IP = \"$ebotip\"/g" ${ebothome}/config/config.ini

#npm shit
RUN 	npm install socket.io formidable archiver

EXPOSE 12360 12361

ADD	entrypoint.sh /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
