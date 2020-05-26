FROM maven:3-alpine

LABEL Author="Selcuk SERT" mail="selcuk.sert@gmail.com"

ARG VERSION=v5.4.1
ARG PROJECT_NAME=kafka-rest
ARG APP_SRC_HOME=https://github.com/confluentinc/${PROJECT_NAME}.git

ENV APP_ROOT=/usr/share/confluent
ENV APP_HOME=${APP_ROOT}/${PROJECT_NAME}
ENV PATH=${PATH}:${APP_HOME}/bin
ENV TZ=Europe/Istanbul

EXPOSE 8081

RUN apk --update add git bash && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

WORKDIR ${APP_ROOT}

RUN git clone ${APP_SRC_HOME}

WORKDIR ${APP_HOME}

RUN git checkout ${VERSION} && \
	sed 's/\${confluent.maven.repo}/https:\/\/packages.confluent.io\/maven\//g' pom.xml > pom_fix_url_error.xml && \
	echo "Start packaging" && mvn -f pom_fix_url_error.xml -DskipTests=true -Dcheckstyle.skip=true -Dmaven.test.skip=true -Dmaven.site.skip=true -Dmaven.javadoc.skip=true -Dspotbugs.skip=true clean install
	
COPY ./scripts/start.sh ${APP_HOME}/bin/
	
ENTRYPOINT ["start.sh"]