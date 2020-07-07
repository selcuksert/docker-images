FROM ubuntu

LABEL Author="Selcuk SERT" mail="selcuk.sert@gmail.com"

ARG PRM_RELEASE=2.19.2
ARG GRF_RELEASE=7.0.5
ENV TZ=Europe/Istanbul

RUN apt-get update && \
apt-get install -y wget adduser libfontconfig1

# Install prometheus
RUN cd /tmp && \
wget -q https://github.com/prometheus/prometheus/releases/download/v${PRM_RELEASE}/prometheus-${PRM_RELEASE}.linux-amd64.tar.gz && \
tar -xvzf prometheus-${PRM_RELEASE}.linux-amd64.tar.gz --directory /usr/share && \
groupadd --system prometheus && useradd -s /sbin/nologin -r -g prometheus prometheus && \
mkdir -p /etc/prometheus/{rules,rules.d,files_sd} /var/lib/prometheus && \
cd /usr/share/prometheus-${PRM_RELEASE}.linux-amd64 && \
cp prometheus promtool /usr/local/bin/ && cp -r consoles/ console_libraries/ /etc/prometheus/ && \
cp /usr/share/prometheus-${PRM_RELEASE}.linux-amd64/prometheus.yml /etc/prometheus/ && \
chown -R prometheus:prometheus /etc/prometheus/ /var/lib/prometheus/ && \
chmod -R 775 /etc/prometheus/ /var/lib/prometheus/

# Install Grafana 
RUN cd /tmp && \
wget -q https://dl.grafana.com/oss/release/grafana_${GRF_RELEASE}_amd64.deb && \
dpkg -i grafana_${GRF_RELEASE}_amd64.deb
 
COPY ./scripts/start.sh /usr/local/bin/

WORKDIR /usr/local/bin/

ENTRYPOINT ["start.sh"]