FROM debian:wheezy
MAINTAINER Stan <teftin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y openjdk-7-jre-headless gitweb lynx-cur git

ADD https://www.gerritcodereview.com/download/gerrit-2.12.war /
RUN java -jar /gerrit-2.12.war init --batch --no-auto-start --site-path /gerrit-app
ADD https://github.com/davido/gerrit-oauth-provider/releases/download/v2.11.3/gerrit-oauth-provider.jar /gerrit-app/plugins

ADD run.sh /run.sh

VOLUME /gerrit

EXPOSE 8080
EXPOSE 29418

CMD exec bash /run.sh
