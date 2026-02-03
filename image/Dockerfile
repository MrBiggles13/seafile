FROM docker.seadrive.org/seafileltd/seafile-pro-mc:11.0-latest

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends clamav \
 && rm -rf /var/lib/apt/lists/*

COPY clamdscan.conf /etc/clamav/clamdscan.conf
COPY seafile-clamdscan /opt/seafile/seafile-clamdscan

RUN chmod +x /opt/seafile/seafile-clamdscan \
 && test -s /opt/seafile/seafile-clamdscan

