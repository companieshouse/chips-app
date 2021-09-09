#!/bin/bash

# Set the env vars in the jms.properties file
cd ~/${DOMAIN_NAME}/chipsconfig
envsubst < jms.properties.template > jms.properties

~/container-scripts/startNodeManagerAndManagedServer.sh

