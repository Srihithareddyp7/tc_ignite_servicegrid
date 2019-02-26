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

RUN wget archive.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz /tmp

# install maven

RUN tar xzf /tmp/apache-maven-3.5.0.tar.gz -C /opt/
RUN mv /opt/apache-maven-3.5.0 /opt/maven
RUN cp /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.5.0.tar.gz
ENV MAVEN_HOME /opt/maven
COPY A-Ignite $IGNITE_HOME/
WORKDIR $IGNITE_HOME/A-Ignite
RUN mvn package
WORKDIR $IGNITE_HOME/A-Ignite/target

EXPOSE 11211 47100 47500 49112

RUN java -cp apacheIgnite-1.0-SNAPSHOT-jar-with-dependencies.jar com.ignite.servicegrid.ServicesExample
