FROM debian:latest

MAINTAINER Jakub Szczyglowski <jszczyglowski@gmail.com>

ENV STEAM_HOME /home/steam/steamcmd

RUN apt-get update && apt-get install -y wget lib32z1 lib32ncurses5 lib32bz2-1.0 lib32gcc1

RUN useradd -m steam

USER steam

RUN mkdir "$STEAM_HOME"

WORKDIR "$STEAM_HOME"

# Served over http :(
RUN wget -O - http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar xvz --directory "$STEAM_HOME"

ADD tf2_ds.txt "$STEAM_HOME/"

RUN "$STEAM_HOME/steamcmd.sh" +login anonymous +force_install_dir ./tf2 +app_update 232250 +quit

ADD server.cfg "$STEAM_HOME/tf2/tf/cfg/"

EXPOSE 27015 27015/udp

ENTRYPOINT ["/home/steam/steamcmd/tf2/srcds_run", "-autoupdate", "-steam_dir", "/home/steam/steamcmd", "-steamcmd_script", "/home/steam/steamcmd/tf2_ds.txt", "-game", "tf"]

CMD ["+sv_pure", "1", "+map", "cp_granary", "+maxplayers", "22"]
