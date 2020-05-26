FROM openjdk:12-alpine

LABEL Author="Selcuk SERT" mail="selcuk.sert@gmail.com"

ENV VERSION=2.5.0
ENV ARCH_VERSION=2.12-${VERSION}
ENV JMX_AGENT_VER=0.12.0
ENV KAFKA_ROOT=/usr/share/kafka
ENV KAFKA_BIN_URL=https://downloads.apache.org/kafka/${VERSION}/kafka_${ARCH_VERSION}.tgz
ENV KAFKA_HOME=${KAFKA_ROOT}/kafka_${ARCH_VERSION}
ENV PATH=${PATH}:${KAFKA_HOME}/bin
ENV TZ=Europe/Istanbul

WORKDIR ${KAFKA_ROOT}

RUN apk --no-cache add bash && wget -q ${KAFKA_BIN_URL} && tar -xzf kafka_${ARCH_VERSION}.tgz -C ${KAFKA_ROOT}
RUN mkdir ${KAFKA_ROOT}/jmx_exporter \
&& wget -O ${KAFKA_ROOT}/jmx_exporter/jmx_prometheus_javaagent.jar https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_AGENT_VER}/jmx_prometheus_javaagent-${JMX_AGENT_VER}.jar \
&& wget -O ${KAFKA_ROOT}/jmx_exporter/kafka-config.yml https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-2_0_0.yml 

ADD ./scripts/*.sh ${KAFKA_HOME}/bin/

WORKDIR ${KAFKA_HOME}/bin

ENTRYPOINT ["startBroker.sh"]