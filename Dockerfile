FROM debian:jessie
MAINTAINER Francis Gassert <fgassert@wri.org>
ARG NAME=nrt-container
ENV NAME ${NAME}

RUN apt-get update
RUN apt-get install -y cron git curl rsyslog

WORKDIR /opt/$NAME/
RUN curl -fs -o docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-17.09.1-ce.tgz
RUN tar xzvf docker.tgz
RUN cp docker/* /usr/bin

COPY entrypoint.sh .
COPY .env .
RUN chmod +x entrypoint.sh
RUN service rsyslog start

CMD ./entrypoint.sh && cron -L 15 && tail -f /var/log/syslog
