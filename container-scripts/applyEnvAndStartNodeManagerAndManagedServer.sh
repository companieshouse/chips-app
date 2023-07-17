#!/bin/bash

# Set the env vars in the jms.properties file
cd ~/${DOMAIN_NAME}/chipsconfig
envsubst < jms.properties.template > jms.properties

# Add ApplicationConfiguratorOverrides.properties file if required
${ORACLE_HOME}/container-scripts/applicationConfiguratorOverrides.sh

~/container-scripts/startNodeManagerAndManagedServer.sh

