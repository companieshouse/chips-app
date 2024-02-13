FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/chips-domain:1.0.42 as builder

USER root

# Copy over app specific chipsconfg
COPY --chown=weblogic:weblogic chipsconfig ${DOMAIN_NAME}/chipsconfig/

# Copy over artefacts
COPY --chown=weblogic:weblogic weblogic-*.tar ${DOMAIN_NAME}/upload/weblogic.tar
COPY --chown=weblogic:weblogic chips-rest-interfaces-*.war ${DOMAIN_NAME}/upload/chips-rest-interfaces.war

# Expand the weblogic application artefact
USER weblogic
RUN cd ${DOMAIN_NAME}/upload && \
    tar -xvf weblogic.tar && \
    cp -r weblogic/* ../chipsconfig && \
    rm ../chipsconfig/chips.ear && \
    rm weblogic.tar

FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/chips-domain:1.0.42

# Copy over upload and chipsconfig
COPY --from=builder --chown=weblogic:weblogic /apps/oracle/${DOMAIN_NAME}/upload ${DOMAIN_NAME}/upload/
COPY --from=builder --chown=weblogic:weblogic /apps/oracle/${DOMAIN_NAME}/chipsconfig ${DOMAIN_NAME}/chipsconfig/

# Copy over utility scripts
COPY --chown=weblogic:weblogic container-scripts container-scripts/

# Set permissions and move tif files into correct location
RUN chmod 754 container-scripts/*.sh && \
    mkdir ${DOMAIN_NAME}/CloudImages && \
    mkdir ${DOMAIN_NAME}/EFAttachments && \
    mv ${DOMAIN_NAME}/upload/weblogic/*.tif ${DOMAIN_NAME}

CMD ["bash"]
