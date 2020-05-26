FROM maven:3-jdk-8

MAINTAINER Selcuk SERT <selcuk.sert@gmail.com>

ARG VERSION=v5.4.1
ARG PROJECT_NAME=ksql
ARG KSQL_SRC_HOME=https://github.com/confluentinc/${PROJECT_NAME}.git

ENV KSQL_ROOT=/usr/share/confluent
ENV KSQL_HOME=${KSQL_ROOT}/${PROJECT_NAME}
ENV PATH=${PATH}:${KSQL_HOME}/bin
ENV TZ=Europe/Istanbul

EXPOSE 8088

WORKDIR ${KSQL_ROOT}

RUN git clone ${KSQL_SRC_HOME}

WORKDIR ${KSQL_HOME}

RUN git checkout ${VERSION} && mvn -DskipTests=true -Dcheckstyle.skip=true -Dmaven.test.skip=true -Dmaven.site.skip=true -Dmaven.javadoc.skip=true -Dspotbugs.skip=true clean install
	
COPY ./scripts/start.sh ${KSQL_HOME}/bin/

RUN apt-get update && apt-get install -y netcat
	
ENTRYPOINT ["start.sh"]