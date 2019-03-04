# Start from a Java image.
FROM openjdk:8

# Ignite version
ENV IGNITE_VERSION 2.6.0

# Ignite home
ENV IGNITE_HOME /opt/ignite/apache-ignite-fabric-${IGNITE_VERSION}-bin

# Do not rely on anything provided by base image(s), but be explicit, if they are installed already it is noop then
RUN  apk update && apk upgrade && apk add --update bash curl unzip;

WORKDIR /opt/ignite

RUN wget  http://archive.apache.org/dist/ignite/2.6.0/apache-ignite-fabric-2.6.0-bin.zip
    && unzip -q apache-ignite-fabric-2.6.0-bin.zip
    && rm apache-ignite-fabric-2.6.0-bin.zip

# Copy sh files and set permission
COPY ./run.sh $IGNITE_HOME/

RUN chmod +x $IGNITE_HOME/run.sh

CMD $IGNITE_HOME/run.sh

EXPOSE 11211 47100 47500 47501 49112
