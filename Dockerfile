FROM openjdk:8u121-jre-alpine

ENV IGNITE_HOME /opt/ignite/IGNITE-2_7

RUN mkdir -p /opt/ignite
WORKDIR /opt/ignite

# Install Apache Ignite
RUN apk update; apk upgrade; apk add --update bash curl unzip;
RUN    wget http://mirrors.estointernet.in/apache//ignite/2.7.0/apache-ignite-2.7.0-bin.zip
RUN    unzip -q apache-ignite-2.7.0-bin.zip
RUN     mv apache-ignite-2.7.0-bin IGNITE-2_7
RUN chmod +x $IGNITE_HOME/bin/ignite.sh

WORKDIR $IGNITE_HOME/bin

EXPOSE 11211 47100 47500 49112

CMD ./ignite.sh
