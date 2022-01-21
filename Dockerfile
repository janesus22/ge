FROM amd64/docker

LABEL version: 4.6.4.0

RUN docker pull emby/embyserver:latest

RUN mkdir -p multimedia/{videos,musica,peliculas}

WORKDIR /multimedia

EXPOSE 8080 8920 7359/udp 1900/udp

CMD /opt/emby-server/bin/emby-server
