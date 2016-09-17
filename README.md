docker-eBot
==========

This is a Docker image of eBot.
Please be aware that this is only the server.

The web-version of this will be done soon.

Usage
-----
Provide following environment variables, when running the image through `docker` or `docker-compose`:

* `EXTERNAL_IP
* `MYSQL_HOST`
* `MYSQL_PORT`
* `MYSQL_USER`
* `MYSQL_PASS`
* `MYSQL_DB`

example for docker run:
```
docker run \
  -v /docker/ebot/demos:/ebot/demos \
  -v /docker/ebot/logs:/ebot/logs \
  -p 12360:12360 \
  -p 12361:12361 \
  --name ebot \
  ebot-docker
```

Usage with HTTPS webinterface
-----------------------------

Visit [https://github.com/carazzim0/nginx-eBot](https://github.com/carazzim0/nginx-eBot) for nginx https configuration.
