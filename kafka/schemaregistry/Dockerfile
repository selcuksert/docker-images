FROM maven:3-alpine

LABEL Author="Selcuk SERT" mail="selcuk.sert@gmail.com"

ARG VERSION=v5.4.1
ARG PROJECT_NAME=schema-registry
ARG SR_SRC_HOME=https://github.com/confluentinc/${PROJECT_NAME}.git

ENV SR_ROOT=/usr/share/confluent
ENV SR_HOME=${SR_ROOT}/${PROJECT_NAME}
ENV PATH=${PATH}:${SR_HOME}/bin
ENV TZ=Europe/Istanbul

EXPOSE 8081

RUN apk --update add git bash && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

WORKDIR ${SR_ROOT}

RUN git clone ${SR_SRC_HOME}

WORKDIR ${SR_HOME}

RUN git checkout ${VERSION} && \
	sed 's/\${confluent.maven.repo}/https:\/\/packages.confluent.io\/maven\//g' pom.xml > pom_fix_url_error.xml && \
	echo "Start packaging" && mvn -f pom_fix_url_error.xml -DskipTests=true -Dcheckstyle.skip=true -Dmaven.test.skip=true -Dmaven.site.skip=true -Dmaven.javadoc.skip=true -Dspotbugs.skip=true clean install
	
COPY ./scripts/start.sh ${SR_HOME}/bin/
	
ENTRYPOINT ["start.sh"]