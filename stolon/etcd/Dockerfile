FROM debian

ARG ETCD_VERSION=v3.5.0
ARG ETCD_HOME=/var/lib/etcd

ENV PATH=${PATH}:${ETCD_HOME}/etcd-${ETCD_VERSION}-linux-amd64

COPY ./scripts/start.sh /usr/local/bin/start

RUN chmod a+x /usr/local/bin/start

RUN apt-get update && apt-get install -y wget

RUN wget -P ${ETCD_HOME} https://github.com/etcd-io/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \
tar -C ${ETCD_HOME} -xvzf ${ETCD_HOME}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz

ENTRYPOINT ["bash", "-c", "start"]