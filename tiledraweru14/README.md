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

2) Add /mnt storage space
TODO: Update path usage
The https://github.com/nkiraly/Tile-Drawer script based provisioning assumed you are building the map tile server on an AWS machine with ephemeral storage on /mnt
To mock this with the virtualbox provider, add a drive to the VM with approximately 100x storage of the size of all of the PBF you are importing. Meaning if you are importing us-northeast-latest.osm-QOjmdL.pbf with is ~ 622MM then your /mnt drive should be 62GB.

To add the drive in ubuntu you would initialize the filesystem and add it to fstab like this:

```bash
$ vagrant ssh

# sudo fdisk -u /dev/sdb <<EOF
p
n
p
1


t
8e
w
p
EOF

# sudo fdisk -l /dev/sdb

# sudo mkfs -t ext4 /dev/sdb1

# sudo vi /etc/fstab
/dev/sdb1    /mnt   ext4    defaults     0        2

# sudo mount /mnt
```


3) Import desired map data

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

4) Finalize config to serve tiles and slippymap from the HTTP root

```bash
$ vagrant ssh

# sudo sh /usr/local/tiledrawer/draw.sh

```

If you are using the default Vagrantfile configuration in this repo, now you can browse the map served at http://10.0.3.10/ from the machine hosting the VM.

# References
- Discussion on resizing vagrant box vmdk https://github.com/mitchellh/vagrant/issues/2339
- Blog on resizing a vagrant vmdk http://blog.lenss.nl/2012/09/resize-a-vagrant-vmdk-drive/
