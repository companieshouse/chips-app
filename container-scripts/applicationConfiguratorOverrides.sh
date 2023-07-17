#!/bin/bash

# This script enumerates all environment variables named APPLICATION_CONFIGURATOR_OVERRIDE_*
# and then adds the valus into an overrides file.  This allows specific properties to be overridden
# on a per environment, or even per node, basis.
# The variable names are of the form APPLICATION_CONFIGURATOR_OVERRIDE_#, where # is a suffix to 
# ensure each variable has a unique name.  Normally this is just a number  - e.g. APPLICATION_CONFIGURATOR_OVERRIDE_1,
# APPLICATION_CONFIGURATOR_OVERRIDE_2 etc


DOMAIN_HOME="/apps/oracle/${DOMAIN_NAME}"
OVERRIDES_FILE="${DOMAIN_HOME}/chipsconfig/ApplicationConfiguratorOverrides.properties"

# Remove any existing overrides file
rm -rf ${OVERRIDES_FILE}

# Loop through all APPLICATION_CONFIGURATOR_OVERRIDE env vars and add to a new ApplicationConfiguratorOverrides.properties file
OVERRIDES=$(env | sort | grep "^APPLICATION_CONFIGURATOR_OVERRIDE_")
for OVERRIDE in ${OVERRIDES};
do
  echo ${OVERRIDE#*=} >> ${OVERRIDES_FILE}
done
