FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get -y install curl gnupg \
 && rm -rf /var/lib/apt/lists/*

ARG REPO=release
 
RUN curl -s https://packagecloud.io/install/repositories/fdio/${REPO}/script.deb.sh | bash \
 && apt-get update \
 && apt-get install -y vpp vpp-plugins \
 && rm -rf /var/lib/apt/lists/*

RUN dpkg -l vpp

COPY vpp.conf /etc/vpp/vpp.conf

CMD ["/usr/bin/vpp","-c","/etc/vpp/vpp.conf"]

