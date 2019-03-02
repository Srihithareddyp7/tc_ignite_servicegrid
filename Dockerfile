FROM openjdk:8u121-jre-alpine

ENV IGNITE_HOME /opt/IGNITE-2_6


WORKDIR /opt/

# Install Apache Ignite
RUN  apk update && apk upgrade && apk add --update bash curl unzip;
RUN    wget  http://archive.apache.org/dist/ignite/2.6.0/apache-ignite-fabric-2.6.0-bin.zip
RUN    unzip -q apache-ignite-fabric-2.6.0-bin.zip
RUN     mv apache-ignite-fabric-2.6.0-bin IGNITE-2_6
RUN chmod +x $IGNITE_HOME/bin/ignite.sh 
RUN mkdir -p /opt/IGNITE-2_6/A-Ignite
ADD A-Ignite /opt/IGNITE-2_6/A-Ignite

WORKDIR /opt/IGNITE-2_6/
./ignite.sh /opt/IGNITE-2_6/A-Ignite/config/example-ignite.xml

WORKDIR /opt/IGNITE-2_6/A-Ignite/target

CMD java -cp apacheIgnite-1.0-SNAPSHOT-jar-with-dependencies.jar com.ignite.servicegrid.ServicesExample

EXPOSE 11211 47100 47500 47501 47502 47503 47504 47505 47506 47507 47508 47509 49112
