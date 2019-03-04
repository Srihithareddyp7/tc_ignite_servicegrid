FROM openjdk:8u121-jre-alpine

ENV IGNITE_HOME /opt/IGNITE-2_6


WORKDIR /opt/

# Install Apache Ignite
RUN  apk update && apk upgrade && apk add --update bash curl unzip;
RUN    wget  http://archive.apache.org/dist/ignite/2.6.0/apache-ignite-fabric-2.6.0-bin.zip
RUN    unzip -q apache-ignite-fabric-2.6.0-bin.zip
RUN     mv apache-ignite-fabric-2.6.0-bin IGNITE-2_6

COPY ./run.sh $IGNITE_HOME/

RUN chmod +x $IGNITE_HOME/run.sh

CMD $IGNITE_HOME/run.sh

EXPOSE 11211 47100 47500 49112

