FROM openjdk:8u121-jre-alpine

ENV IGNITE_HOME /opt/IGNITE-2_6


WORKDIR /opt/

# Install Apache Ignite
RUN  apk update && apk upgrade && apk add --update bash curl unzip;
RUN    wget  http://archive.apache.org/dist/ignite/2.6.0/apache-ignite-fabric-2.6.0-bin.zip
RUN    unzip -q apache-ignite-fabric-2.6.0-bin.zip
RUN     mv apache-ignite-fabric-2.6.0-bin IGNITE-2_6
#RUN chmod +x $IGNITE_HOME/bin/ignite.sh 
RUN $IGNITE_HOME/bin/ignite.sh 

EXPOSE 11211 47100 47500 47501 47502 47503 47504 47505 47506 47507 47508 47509 49112
