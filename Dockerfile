FROM debian:stretch-slim

MAINTAINER Xiaoming <mail@xiaoming.se>

# PREPARATIONS
ENV DEBIAN_FRONTEND noninteractive


# Set LOCALEs

RUN apt-get clean && apt-get update -q && apt-get install -y locales
ENV LANGUAGE en_US.UTF-8

ENV LANG en_US.UTF-8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# Upgrading debian
RUN apt-mark hold initscripts udev plymouth && \
    apt-get install -y apt-utils && \
    apt-get -q update && \
    apt-get dist-upgrade -qy && apt-get -q update



# Installing Emby-server
RUN apt-get -q update && \
    apt-get install -y curl gnupg && \
    echo 'deb http://download.opensuse.org/repositories/home:/emby/Debian_9.0/ /' > /etc/apt/sources.list.d/home:emby.list && \
    curl -fsSL https://download.opensuse.org/repositories/home:emby/Debian_9.0/Release.key | apt-key add - && \
    apt-get -q update && \
    apt-get -qy --allow-downgrades --allow-remove-essential --allow-change-held-packages install emby-server

#Additional dependencies
RUN apt-get install -qy ffmpeg libavcodec-extra procps

# Clean up
RUN apt-get -qy autoremove

#Setup Datafiles

RUN mkdir /config && \
    echo "EMBY_DATA=/config" > /etc/emby-server.conf && \
    chown emby:emby -R /config
ENV EMBY_DATA /config


VOLUME ["/config"]

#Export default http port
EXPOSE 8096/tcp

#Export default https port
EXPOSE 8920/tcp

#UDP
EXPOSE 7359/udp

#ssdp port for UPnP /DLNA discovery
EXPOSE 1900/udp

# Starting the service
CMD /usr/bin/emby-server start
