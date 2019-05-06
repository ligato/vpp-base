FROM ubuntu:18.04

RUN apt-get update \
 && apt-get install -y \
  	curl \
  	gnupg \
  	sudo \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /vpp

ARG VPP_REPO=master
ARG VPP_VERSION

COPY install_vpp.sh .
RUN bash ./install_vpp.sh \
 && rm -rf /var/lib/apt/lists/*

COPY vpp.conf /etc/vpp/vpp.conf

CMD ["/usr/bin/vpp","-c","/etc/vpp/vpp.conf"]
