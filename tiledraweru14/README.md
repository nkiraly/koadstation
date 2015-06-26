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

1) Configure region map data provisioning should import

2) Create VM

```bash
$ vagrant up
```
