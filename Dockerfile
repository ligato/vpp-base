FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg \
		iproute2 \
		iputils-ping \
		openssh-server \
                vim \
 	&& rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN echo 'root:docker' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ARG REPO
ARG VPP_VERSION

WORKDIR /vpp

COPY get-vpp.sh /get-vpp.sh
COPY start.sh /start.sh

RUN set -eux; \
	/get-vpp.sh; \
	apt-get update && apt-get install -y -V ./*.deb; \
	dpkg-query -f '${Version}\n' -W vpp > /vpp/version; \
	rm -rf vom*.deb vpp-dbg*.deb; \
	rm -rf /var/lib/apt/lists/*;

#RUN service ssh start
EXPOSE 22

RUN mkdir -p /var/log/vpp

CMD ["/start.sh"]
