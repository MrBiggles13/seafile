FROM docker.seadrive.org/seafileltd/seafile-pro-mc:11.0.19

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends clamav xmlsec1 \
 && rm -rf /var/lib/apt/lists/*

COPY clamdscan.conf /etc/clamav/clamdscan.conf
COPY seafile-clamdscan /opt/seafile/seafile-clamdscan

RUN sed -i 's/\r$//' /etc/clamav/clamdscan.conf \
 && sed -i 's/\r$//' /opt/seafile/seafile-clamdscan \
 && chmod 0755 /opt/seafile/seafile-clamdscan \
 && test -s /opt/seafile/seafile-clamdscan \
 && test -s /etc/clamav/clamdscan.conf





