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

#COPY ignite_java.sh /opt/ignite_java.sh
#RUN chmod +x /opt/ignite_java.sh


CMD /opt/IGNITE-2_6/bin/ignite.sh /opt/IGNITE-2_6/A-Ignite/config/example-ignite.xml
WORKDIR /opt/IGNITE-2_6/A-Ignite/target/
RUN java -cp apacheIgnite-1.0-SNAPSHOT-jar-with-dependencies.jar com.ignite.servicegrid.ServicesExample
#CMD sh /opt/ignite_java.sh
EXPOSE 11211 47100 47500 49112
