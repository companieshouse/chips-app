# chips-app
Docker build for chips-app image


This build extends the chips-domain image (https://github.com/companieshouse/docker-cic#cic-domain) and adds the chips and chips-rest-interfaces application files, along with further configuration that allows the CHIPS application to fully function.

### Run time environment properties file
In order to use the image, a number of environment properties need to be defined in a file, held locally to where the docker command is being run - for example, `chips.properties` 
|Property|Description  |Example
|--|--|--
|ADMIN_PASSWORD |The password to set for the weblogic user.  Needs to be at least 8 chars and include a number.|secret123
|DOMAIN_CREDENTIAL|A random string to override and reset the default credential already present in the image.|kjsdgf5464fdva
|LDAP_CREDENTIAL|A random string to override and reset the default credential already present in the image.|ldap01234
|DB_URL|Full JDBC connection string of database|jdbc:oracle:thin:@cicspoc.blahblah.eu-west-2.rds.amazonaws.com:1521:cics
|DB_USER|Database username|CICDBUSER
|DB_PASSWORD|Database passwrod|cicdbpassword
|START_ARGS|Any startup JVM arguments that should be used when starting the managed server|-Dmyarg=true -Dmyotherarg=false
|USER_MEM_ARGS|JVM arguments for setting the GC and memory settings for the managed server.  These will be included at the start of the arguments to the JVM|-XX:+UseG1GC -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xms712m -Xmx712m
|ADMIN_MEM_ARGS|JVM arguments for setting the GC and memory settings for the admin server.  These will be included at the start of the arguments to the JVM|-Djava.security.egd=file:/dev/./urandom -Xms32m -Xmx512m
|AD_HOST|The hostname or ip of the Active Directory server against which to authenticate users|ldap99.domain.ch
|AD_PORT|The port to use for a SSL connection|636
|AD_PRINCIPAL|The user in AD for connecting in order to authenticate other user logins|CN=myldpauser, OU=AD Groups, OU=MySection, OU=MyOrg, DC=MyDepartment, DC=local
|AD_CREDENTIAL|The password of the user in AD for connecting in order to authenticate other user logins|password
|AD_USER_BASE_DN|The base location under which users can be found via a subtree search|OU=MySection, OU=MyOrg, DC=MyDepartment, DC=local
|AD_GROUP_BASE_DN|The base location under which groups can be found via a subtree search|OU=MySection, OU=MyOrg, DC=MyDepartment, DC=local
|AUTO_START_NODES|A list of managed server names to auto start when the container is launched|wlserver1,wlserver2

In addition to these properties which are required for the use of the Docker image, there are also a large number of existing environment properties that are needed to run the CHIPS application.  These are described in https://github.com/companieshouse/chips/blob/develop/ENVIRONMENT_PROPERTIES_README.md and are also listed in this repository https://github.com/companieshouse/chips-app/blob/main/chipsconfig/jms.properties.template

### Building the image
To build the image, from the root of this repo, run:

    docker build -t chips-app .
