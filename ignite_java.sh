#!/bin/bash
nohup /opt/IGNITE-2_6/bin/ignite.sh /opt/IGNITE-2_6/A-Ignite/config/example-ignite.xml" > /dev/null & > /opt/ignite_java.sh
java -cp apacheIgnite-1.0-SNAPSHOT-jar-with-dependencies.jar com.ignite.servicegrid.ServicesExample" >> /opt/ignite_java.sh
