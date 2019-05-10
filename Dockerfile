FROM ubuntu:18.04

RUN apt-get update \
 && apt-get install -qy \
  	curl \
  	gnupg \
  	sudo \
 && rm -rf /var/lib/apt/lists/*

ARG REPO=master
ARG VPP_VERSION

WORKDIR /vpp

COPY get-vpp.sh /opt/

RUN set -eux; \
	/opt/get-vpp.sh; \
	apt-get install -qy /vpp/*.deb; \
	rm -rf /var/lib/apt/lists/*;

COPY vpp.conf /etc/vpp/vpp.conf

CMD ["/usr/bin/vpp","-c","/etc/vpp/vpp.conf"]
