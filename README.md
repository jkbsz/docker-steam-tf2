# docker-steam-tf2
Docker container for running Team Fortress 2 dedicated server.

## Building and running from github
```
docker build -t local/steam-tf2 docker-steam-tf2
docker run -d -i -t -P local/steam-tf2
```

## Running from docker hub
```
docker run -d -P -t jkbsz/steam-tf2
```

## Default server startup options:

+log on +sv_pure 1 +map cp_granary +maxplayers 24

Using own options and port:
```
docker run -d -i -p 27020:27015 -p 27020:27015/udp -t jkbsz/steam-tf2 +sv_pure 1 +map pl_badwater +maxplayers 8
```


