FROM debian:wheezy
MAINTAINER Stan <teftin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y openjdk-7-jre-headless gitweb lynx-cur git augeas-tools

ADD https://gerrit-releases.storage.googleapis.com/gerrit-2.9.war /
RUN java -jar /gerrit-2.9.war init --batch --no-auto-start --site-path /gerrit-app

ADD run.sh /run.sh

VOLUME /gerrit

EXPOSE 8080
EXPOSE 29418

CMD exec bash /run.sh
