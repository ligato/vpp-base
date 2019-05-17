FROM ubuntu:18.04

ARG REPO=master
ARG VPP_VERSION

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg \
		sudo \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /vpp

COPY get-vpp.sh ./get-vpp.sh

RUN set -eux; \
	./get-vpp.sh; \
	dpkg -f vpp_*.deb Version > version; \
    apt-get install -y -V ./*.deb; \
	rm -rf /var/lib/apt/lists/*;

CMD ["/usr/bin/vpp", "-c", "/etc/vpp/startup.conf"]
