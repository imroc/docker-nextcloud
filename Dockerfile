FROM nextcloud:29.0.1-apache

RUN set -ex; \
  \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  supervisor \
  ; \
  rm -rf /var/lib/apt/lists/*

RUN mkdir -p \
  /var/log/supervisord \
  /var/run/supervisord \
  ;

COPY supervisord.conf /

COPY crontab /var/spool/cron/crontabs/www-data

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]

