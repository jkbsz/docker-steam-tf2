FROM debian:latest

MAINTAINER Jakub Szczyglowski <jszczyglowski@gmail.com>

RUN apt-get update && apt-get install -y lib32bz2-1.0 \
	lib32gcc1 \
	lib32ncurses5 \
	lib32z1 \
	wget

RUN useradd -m steam

USER steam

RUN mkdir /home/steam/steamcmd

WORKDIR /home/steam/steamcmd

# Served over http :(
RUN wget -O - http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar xvz --directory /home/steam/steamcmd/

ADD tf2_ds.txt /home/steam/steamcmd/tf2_ds.txt

RUN /home/steam/steamcmd/steamcmd.sh +runscript /home/steam/steamcmd/tf2_ds.txt

EXPOSE 27015 27015/udp

ENTRYPOINT ["/home/steam/steamcmd/tf2/srcds_run", "-autoupdate", "-steam_dir", "/home/steam/steamcmd", "-steamcmd_script", "/home/steam/steamcmd/tf2_ds.txt", "-game", "tf"]

CMD ["+log", "on", "+sv_pure", "1", "+map", "cp_granary", "+maxplayers", "24"]

