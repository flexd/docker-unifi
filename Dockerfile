FROM dayzleaper/docker-debian-jre8:latest

MAINTAINER Robert Frånlund <robert.franlund@poweruser.se>

ENV DEBIAN_FRONTEND noninteractive

# Install Unifi and dependencies
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install wget mongodb-server jsvc && \
    wget -O /tmp/unifi_sysvinit_all.deb \
        https://www.ubnt.com/downloads/unifi/5.0.5-fb1a2577/unifi_sysvinit_all.deb && \
    dpkg --install /tmp/unifi_sysvinit_all.deb && \
    rm -rf /tmp/unifi_sysvinit_all.deb /var/lib/unifi/*

# Expose ports
EXPOSE 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp

# Add start script
ADD assets/start.sh /start.sh

VOLUME ["/var/lib/unifi"]

WORKDIR /var/lib/unifi

CMD ["/start.sh"]
