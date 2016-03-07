dockereBot
==========

This is a Docker image of eBot.
Please be aware that this is only the server.

The web-version of this will be done soon.

Usage
-----
Provide following environment variables, when running the image through `docker` or `docker-compose`:

* `EBOT_IP`
* `MYSQL_HOST`
* `MYSQL_PORT`
* `MYSQL_USER
* `MYSQL_PASS
* `MYSQL_DB`

Usage with HTTPS webinterface
-----------------------------

Visit [https://github.com/carazzim0/nginx-eBot](https://github.com/carazzim0/nginx-eBot) for nginx https configuration.
