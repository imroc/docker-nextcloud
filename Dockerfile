FROM nextcloud:29.0.9-apache

RUN set -ex && \
  apt-get update -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ffmpeg \
  libreoffice \
  supervisor 

RUN apt-get clean autoclean && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir -p \
  /var/log/supervisord \
  /var/run/supervisord

COPY supervisord.conf /

COPY crontab /var/spool/cron/crontabs/www-data

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]

