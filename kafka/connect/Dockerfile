FROM openjdk:12

LABEL Author="Selcuk SERT" mail="selcuk.sert@gmail.com"

ARG KAFKA_VERSION=5.4.1
ARG AVRO_VERSION=1.9.1
ARG MYSQL_CON_VERSION=8.0.19
ARG DEBEZIUM_CON_VERSION=1.1.1.Final
ENV VERSION=2.5.0
ENV ARCH_VERSION=2.12-${VERSION}
ENV JMX_AGENT_VER=0.12.0
ENV KAFKA_ROOT=/usr/share/kafka
ENV KAFKA_BIN_URL=https://downloads.apache.org/kafka/${VERSION}/kafka_${ARCH_VERSION}.tgz
ENV KAFKA_HOME=${KAFKA_ROOT}/kafka_${ARCH_VERSION}
ENV PATH=${PATH}:${KAFKA_HOME}/bin
ENV TZ=Europe/Istanbul

ADD ./scripts/*.sh ${KAFKA_HOME}/bin/
ADD ./config/*.properties ${KAFKA_HOME}/config/

RUN yum install -y wget nc && wget -q ${KAFKA_BIN_URL} && tar -xzf kafka_${ARCH_VERSION}.tgz -C ${KAFKA_ROOT}

RUN wget -q -P ${KAFKA_HOME}/libs/ https://packages.confluent.io/maven/io/confluent/kafka-schema-registry-client/${KAFKA_VERSION}/kafka-schema-registry-client-${KAFKA_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://packages.confluent.io/maven/io/confluent/kafka-connect-avro-converter/${KAFKA_VERSION}/kafka-connect-avro-converter-${KAFKA_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://packages.confluent.io/maven/io/confluent/kafka-avro-serializer/${KAFKA_VERSION}/kafka-avro-serializer-${KAFKA_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://packages.confluent.io/maven/io/confluent/common-utils/${KAFKA_VERSION}/common-utils-${KAFKA_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://packages.confluent.io/maven/io/confluent/common-config/${KAFKA_VERSION}/common-config-${KAFKA_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://repo1.maven.org/maven2/org/apache/avro/avro/${AVRO_VERSION}/avro-${AVRO_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CON_VERSION}/mysql-connector-java-${MYSQL_CON_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.2/antlr4-runtime-4.7.2.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://repo1.maven.org/maven2/io/debezium/debezium-api/${DEBEZIUM_CON_VERSION}/debezium-api-${DEBEZIUM_CON_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://repo1.maven.org/maven2/io/debezium/debezium-core/${DEBEZIUM_CON_VERSION}/debezium-core-${DEBEZIUM_CON_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://repo1.maven.org/maven2/io/debezium/debezium-ddl-parser/${DEBEZIUM_CON_VERSION}/debezium-ddl-parser-${DEBEZIUM_CON_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/libs/ https://repo1.maven.org/maven2/com/github/shyiko/mysql-binlog-connector-java/0.19.1/mysql-binlog-connector-java-0.19.1.jar


RUN mkdir ${KAFKA_HOME}/plugins/ && \
wget -q -P ${KAFKA_HOME}/plugins/ https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/${KAFKA_VERSION}/kafka-connect-jdbc-${KAFKA_VERSION}.jar && \
wget -q -P ${KAFKA_HOME}/plugins/ https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/${DEBEZIUM_CON_VERSION}/debezium-connector-mysql-${DEBEZIUM_CON_VERSION}.jar
WORKDIR ${KAFKA_HOME}/bin

ENTRYPOINT ["start.sh"]