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

RUN wget --no-verbose -O /tmp/apache-maven-3.2.2.tar.gz http://archive.apache.org/dist/maven/maven-3/3.2.2/binaries/apache-maven-3.2.2-bin.tar.gz

# verify checksum

RUN echo "87e5cc81bc4ab9b83986b3e77e6b3095 /tmp/apache-maven-3.2.2.tar.gz" | md5sum -c

# install maven

RUN tar xzf /tmp/apache-maven-3.2.2.tar.gz -C /opt/
RUN mv /opt/apache-maven-3.2.2 /opt/maven
RUN cp /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.2.2.tar.gz
ENV MAVEN_HOME /opt/maven
COPY A-Ignite $IGNITE_HOME/
WORKDIR $IGNITE_HOME/A-Ignite
RUN mvn package
WORKDIR $IGNITE_HOME/A-Ignite/target

EXPOSE 11211 47100 47500 49112

RUN java -cp apacheIgnite-1.0-SNAPSHOT-jar-with-dependencies.jar com.ignite.servicegrid.ServicesExample
