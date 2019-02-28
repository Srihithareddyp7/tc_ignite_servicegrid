FROM openjdk:8u121-jre-alpine

ENV IGNITE_HOME /opt/IGNITE-2_7

RUN mkdir -p /opt/ignite
WORKDIR /opt/

# Install Apache Ignite
RUN  apk update && apk upgrade && apk add --update bash curl unzip;
RUN    wget  http://www-us.apache.org/dist//ignite/2.7.0/apache-ignite-2.7.0-bin.zip
RUN    unzip -q apache-ignite-2.7.0-bin.zip
RUN     mv apache-ignite-2.7.0-bin IGNITE-2_7
RUN chmod +x $IGNITE_HOME/bin/ignite.sh

RUN mkdir -p /opt/ignite/A-Ignite
COPY A-Ignite/* /opt/IGNITE-2_7/A-Ignite/

WORKDIR $IGNITE_HOME

EXPOSE 11211 47100 47500 49112
#RUN java -cp apacheIgnite-1.0-SNAPSHOT-jar-with-dependencies.jar com.ignite.servicegrid.ServicesExample
