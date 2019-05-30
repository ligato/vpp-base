FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg \
 	&& rm -rf /var/lib/apt/lists/*

ARG REPO
ARG VPP_VERSION

WORKDIR /vpp

COPY get-vpp.sh /get-vpp.sh

RUN set -eux; \
	/get-vpp.sh; \
    apt-get install -y -V ./*.deb; \
	dpkg-query -f '${Version}\n' -W vpp; \
	rm -rf /var/lib/apt/lists/*;

RUN mkdir -p /var/log/vpp

CMD ["/usr/bin/vpp", "-c", "/etc/vpp/startup.conf"]
