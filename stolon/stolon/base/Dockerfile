FROM debian:buster-slim
LABEL author="Selcuk SERT"
LABEL mail="selcuk.sert@gmail.com"
LABEL version="1.0"
LABEL description="Custom stolon (PostgreSQL HA) image based on Debian buster"

ARG GO_VERSION=1.16.5

ENV STOLON_HOME=/var/lib/stolon
ENV GO_HOME=/usr/local/go
ENV PATH=${PATH}:${STOLON_HOME}/stolon-master/bin:${GO_HOME}/bin
ENV ETCDCTL_API=3

COPY ./scripts/start.sh /usr/local/bin/start

COPY ./scripts/init.sh /usr/local/bin/init

RUN chmod a+x /usr/local/bin/start &&  chmod a+x /usr/local/bin/init

RUN apt-get update && apt-get install -y wget netcat etcd-client gosu unzip git build-essential

RUN wget -P ${STOLON_HOME} https://github.com/sorintlab/stolon/archive/refs/heads/master.zip

RUN wget -P /usr/local https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
tar -C /usr/local/ -xzf /usr/local/go${GO_VERSION}.linux-amd64.tar.gz

WORKDIR ${STOLON_HOME}

RUN unzip ./master.zip

WORKDIR ${STOLON_HOME}/stolon-master

RUN make

RUN groupadd -g 1000 stolon && \
useradd -g 1000 -u 1000 stolon

ENTRYPOINT ["bash", "-c", "start"]