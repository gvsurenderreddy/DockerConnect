FROM alpine:latest
MAINTAINER Marco Garcês "marco@garces.cc"

ENV REFRESHED_AT 2016-04-22

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk upgrade --update && \
  apk add -u python py-pip && \
  apk add openssh openconnect@testing bash && \
  pip install --upgrade pip && \
  pip install supervisor && \
  mkdir -p ~root/.ssh && chmod 700 ~root/.ssh/ && \
  echo -e "Port 22\n" >> /etc/ssh/sshd_config && \
  cp -a /etc/ssh /etc/ssh.cache && \
  rm -rf /var/cache/apk/*

COPY entry.sh /entry.sh
COPY vpn.sh /vpn.sh
COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]

EXPOSE 22
