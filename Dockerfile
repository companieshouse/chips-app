FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/chips-domain:1.0.21

# Install gettext to provide envsubst
USER root
RUN yum -y install gettext && \
    yum clean all && \
    rm -rf /var/cache/yum

# Copy over app specific chipsconfg
COPY --chown=weblogic:weblogic chipsconfig ${DOMAIN_NAME}/chipsconfig/

# Copy over utility scripts
COPY --chown=weblogic:weblogic container-scripts container-scripts/

# Copy over artefacts
COPY --chown=weblogic:weblogic weblogic-*.tar ${DOMAIN_NAME}/upload/weblogic.tar
COPY --chown=weblogic:weblogic chips-rest-interfaces-*.war ${DOMAIN_NAME}/upload/chips-rest-interfaces.war

# Set permissions on utility scripts, expand the weblogic application artefact and create directories for volumes
USER weblogic
RUN chmod 754 container-scripts/*.sh && \
    cd ${DOMAIN_NAME}/upload && \
    tar -xvf weblogic.tar && \
    cp -r weblogic/* ../chipsconfig && \
    rm ../chipsconfig/chips.ear && \
    mkdir ../CloudImages && \
    mkdir ../EFAttachments

CMD ["bash"]
