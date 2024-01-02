FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		gnupg \
		iproute2 \
		iputils-ping \
 	&& rm -rf /var/lib/apt/lists/*

WORKDIR /vpp

COPY *.deb ./

RUN set -eux; \
	apt-get update && apt-get install -y -V ./*.deb; \
	dpkg-query -f '${Version}\n' -W vpp > /vpp/version; \
	rm -rf /var/lib/apt/lists/*;

RUN mkdir -p /var/log/vpp

CMD ["/usr/bin/vpp", "-c", "/etc/vpp/startup.conf"]
