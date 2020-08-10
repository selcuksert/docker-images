FROM maven:3-openjdk-8-slim

LABEL author="Selcuk SERT"
LABEL mail="selcuk.sert@gmail.com"
LABEL version="1.0"
LABEL description="Base image for RedHat Process Automation Manager"

ARG PAM_VERSION=7.8.0
ARG EAP_VERSION=7.3

# Environment Variables
ENV HOME /opt/jboss
ENV JBOSS_HOME $HOME/jboss-eap-${EAP_VERSION}
ENV TZ Europe/Istanbul
ENV PATH ${PATH}:${JBOSS_HOME}/bin

RUN apt-get update && apt-get install -y git netcat unzip

RUN addgroup --gid 1000 jboss && \
adduser --system --gid 1000 --home $HOME jboss && \
chmod 755 $HOME

# Update Permissions
RUN chown jboss:jboss $HOME

USER jboss

# ADD Installation Files
ADD ./package/jboss-eap-${EAP_VERSION}.0.zip $HOME/package/
ADD ./package/rhpam-${PAM_VERSION}-business-central-eap7-deployable.zip $HOME/package/
ADD ./package/rhpam-${PAM_VERSION}-kie-server-ee8.zip $HOME/package/
ADD ./package/rhpam-${PAM_VERSION}-add-ons.zip $HOME/package/

# ADD Config Files
ADD ./config/settings.xml /usr/share/maven/conf/settings.xml

USER root

# Update Permissions
RUN chown jboss:jboss $HOME/package

USER jboss

# Extract installation packages
RUN unzip -qo $HOME/package/jboss-eap-${EAP_VERSION}.0.zip -d $HOME && \
unzip -qo $HOME/package/rhpam-${PAM_VERSION}-business-central-eap7-deployable.zip -d $HOME && \
unzip -qo $HOME/package/rhpam-${PAM_VERSION}-kie-server-ee8.zip -d $JBOSS_HOME/standalone/deployments && \
touch $JBOSS_HOME/standalone/deployments/kie-server.war.dodeploy && \
unzip -qo $HOME/package/rhpam-${PAM_VERSION}-add-ons.zip -d $HOME/package && \
unzip -qo $HOME/package/rhpam-${PAM_VERSION}-case-mgmt-showcase-eap7-deployable.zip -d $HOME && \
touch $JBOSS_HOME/standalone/deployments/rhpam-case-mgmt-showcase.war.dodeploy && \
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/ && \
rm -rf $HOME/package
	
# ADD Config Files
ADD ./config/standalone-full.xml $JBOSS_HOME/standalone/configuration/standalone-full-param.xml

# ADD scripts
ADD ./scripts/docker-start.sh ${JBOSS_HOME}/bin/

# Swtich back to root user
USER root

# Fix permissions on support files
RUN chown -R jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full.xml 
# Run as jboss user
USER jboss

RUN sed "s/<security-domain>other<\/security-domain>/<security-domain>ldap<\/security-domain>/g" -i $JBOSS_HOME/standalone/deployments/business-central.war/WEB-INF/jboss-web.xml
RUN sed "s/<security-domain>other<\/security-domain>/<security-domain>ldap<\/security-domain>/g" -i $JBOSS_HOME/standalone/deployments/kie-server.war/WEB-INF/jboss-web.xml

# Expose Ports
EXPOSE 9990 9999 8080

WORKDIR $JBOSS_HOME/standalone/configuration

# Run application
ENTRYPOINT ["docker-start.sh"]