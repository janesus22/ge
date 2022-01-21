FROM centos

MAINTAINER Yonier Gomez yonieer13@gmail.com

LABEL version: 4.6.4.0

RUN dnf -y install https://github.com/MediaBrowser/Emby.Releases/releases/download/4.6.4.0/emby-server-rpm_4.6.4.0_x86_64.rpm

RUN mkdir -p multimedia/{videos,musica,peliculas}

WORKDIR /multimedia

EXPOSE 8096 8920 7359/udp 1900/udp

CMD /opt/emby-server/bin/emby-server
