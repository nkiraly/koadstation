# tiledraweru14

Vagrant provisioning of a Ubuntu 14.04 LTS based map tile server.

Sets up a OpenStreetMaps map tile server utilizing
- nginx
- unicorn
- memcached 
- Cascadenik
- imposm
- TileStache
- mapnik
- PostgreSQL
- PostGIS

This provisioner is based on https://github.com/nkiraly/Tile-Drawer but updated for Ubuntu 14.04 LTS

# Quick Setup Guide

If you want to just get a tile server working and then learn how it works, select a PBF segment of the planet you want to serve from a partial extractor such as http://download.geofabrik.de/north-america.html and follow these top level configuration steps.

1) Create VM

```bash
$ vagrant up
```

If you need to rebuild maps after changing the configuration, comment out provisioning step 010 and reprovision the VM

```bash
$ vagrant provision
```

2) Import desired map data

This example does all of the areas of the US and will take significant resources and time to import. To do a smaller set to test, try using just us-northeast or whatever state or region is local to you. For more pbf bundles, see http://download.geofabrik.de/north-america.html

```bash
$ vagrant ssh

# sudo python /usr/local/tiledrawer/populate.py -b -85.0000 -180.0000 85.0000 180.0000  \
  -s https://raw.github.com/mapnik/Cascadenik/tiledrawer/openstreetmap/style.mml  \
  http://download.geofabrik.de/north-america/us-northeast-latest.osm.pbf  \
  http://download.geofabrik.de/north-america/us-midwest-latest.osm.pbf  \
  http://download.geofabrik.de/north-america/us-pacific-latest.osm.pbf  \
  http://download.geofabrik.de/north-america/us-south-latest.osm.pbf  \
  http://download.geofabrik.de/north-america/us-west-latest.osm.pbf

3) Finalize config to serve tiles and slippymap from the HTTP root

```bash
$ vagrant ssh

# sudo /usr/local/tiledrawer/draw.sh

```
