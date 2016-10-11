docker-ebot
================

Dockerised eBot (https://github.com/deStrO/eBot-CSGO) for ease of use.

Pre-Requisites
--------------
* Edit PUBLIC_IP ENV in the docker-compose.yml
* An host **without** mysql, if you use your own mysql, delete the mysql container in the docker-compose.yml

Settings
---------
Edit the following settings in [docker-compose.yml](docker-compose.yml) to your needs.
#### eBot
````
EXTERNAL_IP: '1.2.3.4'
MYSQL_HOST: '212.1.2.3'
MYSQL_PORT: '3306'
MYSQL_DB: 'ebotv3'
MYSQL_USER: 'ebotv3'
MYSQL_PASS: 'ebotv3'
LO3_METHOD: 'restart'
KO3_METHOD: 'restart'
DEMO_DOWNLOAD: 'true'
REMIND_RECORD: 'false'
DAMAGE_REPORT: 'false'
DELAY_READY: 'false'
````

Run
---

`docker-compose up -d`

Quick start
-----------



Credits
-------
* carazzim0
* destr0
* jeff
