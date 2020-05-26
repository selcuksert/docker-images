FROM openjdk:8-alpine

LABEL Author="Selcuk SERT" mail="selcuk.sert@gmail.com"

ARG PAM_VERSION=7.7.0
ARG EAP_VERSION=7.2

# Environment Variables
ENV HOME /opt/jboss
ENV JBOSS_HOME $HOME/jboss-eap-${EAP_VERSION}
ENV TZ Europe/Istanbul
ENV M2_HOME /usr/share/java/maven-3
ENV PATH ${PATH}:${JBOSS_HOME}/bin

RUN apk --update add git bash maven netcat-openbsd && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN addgroup -g 1000 jboss && \
adduser -u 1000 -G jboss -h $HOME -D jboss && \
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
ADD ./config/settings.xml /usr/share/java/maven-3/conf/settings.xml

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
ADD ./config/userinfo.properties $JBOSS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/

# ADD scripts
ADD ./scripts/docker-start.sh ${JBOSS_HOME}/bin/

# Swtich back to root user
USER root

# Fix permissions on support files
RUN chown -R jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full.xml $JBOSS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/userinfo.properties

# Run as jboss user
USER jboss

RUN sed "s/<security-domain>other<\/security-domain>/<security-domain>ldap<\/security-domain>/g" -i $JBOSS_HOME/standalone/deployments/business-central.war/WEB-INF/jboss-web.xml
RUN sed "s/<security-domain>other<\/security-domain>/<security-domain>ldap<\/security-domain>/g" -i $JBOSS_HOME/standalone/deployments/kie-server.war/WEB-INF/jboss-web.xml

# Expose Ports
EXPOSE 9990 9999 8080

WORKDIR $JBOSS_HOME/standalone/configuration

# Run application
ENTRYPOINT ["docker-start.sh"]