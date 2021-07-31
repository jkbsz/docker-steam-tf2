FROM ubuntu:20.04

RUN dpkg --add-architecture i386
RUN apt update
RUN apt install -y curl wget lib32z1 libncurses5:i386 libbz2-1.0:i386 lib32gcc1 lib32stdc++6 libtinfo5:i386 libcurl3-gnutls:i386 libsdl2-2.0-0:i386

RUN useradd -m steam
USER steam
RUN mkdir /home/steam/steamcmd
WORKDIR /home/steam/steamcmd

# https://developer.valvesoftware.com/wiki/SteamCMD#Linux
RUN curl https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar xvz --directory /home/steam/steamcmd/
ADD tf2_ds.txt /home/steam/steamcmd/tf2_ds.txt
RUN /home/steam/steamcmd/steamcmd.sh +runscript /home/steam/steamcmd/tf2_ds.txt

RUN cp /home/steam/steamcmd/tf2/tf/cfg/pure_server_whitelist_example.txt /home/steam/steamcmd/tf2/tf/cfg/pure_server_whitelist.txt

ADD cfg/* /home/steam/steamcmd/tf2/tf/cfg/
ADD maps/* /home/steam/steamcmd/tf2/tf/maps/

EXPOSE 27015 27015/udp
ENTRYPOINT ["/home/steam/steamcmd/tf2/srcds_run", "-autoupdate", "-steam_dir", "/home/steam/steamcmd", "-steamcmd_script", "/home/steam/steamcmd/tf2_ds.txt", "-game", "tf"]
