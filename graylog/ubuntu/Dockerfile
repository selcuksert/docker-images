FROM ubuntu

LABEL author="Selcuk SERT"
LABEL mail="selcuk.sert@gmail.com"
LABEL version="1.0"
LABEL description="An Ubuntu image with Graylog ready nxlog collector"

ARG SIDECAR_VERSION=0.1.6

# Environment Variables
ENV TZ Europe/Istanbul

WORKDIR $HOME/sidecar

RUN apt-get update && \
apt-get install -y wget && \
wget https://github.com/Graylog2/collector-sidecar/releases/download/$SIDECAR_VERSION/collector-sidecar_$SIDECAR_VERSION-1_amd64.deb && \
dpkg -i collector-sidecar_$SIDECAR_VERSION-1_amd64.deb

# ADD Config File
ADD ./config/collector_sidecar.yml /etc/graylog/collector-sidecar/collector_sidecar.yml

# ADD Test Script
ADD ./script/test.sh ./script/test.sh
 
RUN wget https://nxlog.co/system/files/products/files/348/nxlog-ce_2.10.2150_ubuntu_bionic_amd64.deb && \
wget http://archive.ubuntu.com/ubuntu/pool/main/p/perl/perl-modules-5.26_5.26.1-6_all.deb && \
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb && \
wget http://archive.ubuntu.com/ubuntu/pool/main/g/gdbm/libgdbm5_1.14.1-6_amd64.deb && \
wget http://archive.ubuntu.com/ubuntu/pool/main/p/perl/libperl5.26_5.26.1-6_amd64.deb

RUN apt install -y ./perl-modules-5.26_5.26.1-6_all.deb && \
apt install -y ./libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb && \
apt install -y ./libgdbm5_1.14.1-6_amd64.deb && \
apt install -y ./libperl5.26_5.26.1-6_amd64.deb && \
apt install -y ./nxlog-ce_2.10.2150_ubuntu_bionic_amd64.deb
 
# Run collector sidecar
ENTRYPOINT ["graylog-collector-sidecar"]