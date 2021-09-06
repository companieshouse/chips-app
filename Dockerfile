#FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/chips-domain
FROM chips-domain

# Copy over app specific chipsconfg
COPY --chown=weblogic:weblogic chipsconfig ${DOMAIN_NAME}/chipsconfig/

# Copy over utility scripts
COPY --chown=weblogic:weblogic container-scripts container-scripts/

# Set permissions on utility scripts and create upload folder to receive the application artefacts 
RUN chmod 754 container-scripts/*.sh && \
    mkdir -p ${DOMAIN_NAME}/upload

COPY --chown=weblogic:weblogic weblogic-*.tar ${DOMAIN_NAME}/upload/weblogic.tar
COPY --chown=weblogic:weblogic chips-rest-interfaces-*.war ${DOMAIN_NAME}/upload/chips-rest-interfaces.war

RUN cd ${DOMAIN_NAME}/upload && \
    tar -xvf weblogic.tar && \
    cp -r weblogic/* ../chipsconfig && \
    rm ../chipsconfig/chips.ear

CMD ["bash"]
