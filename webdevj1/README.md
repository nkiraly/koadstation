# What is webdevj1 ?

webdevj1 was based on webdevf1 FreeBSD 10.1 web development but is more complex in that it has several function-segregated jails in it. It uses [ansible-sshjail](https://github.com/austinhyde/ansible-sshjail) to streamline ansible interactions without resorting to running sshd in a jail.


# Installing Dependencies for webdevj1

webdevj1 depends on [ansible-sshjail](https://github.com/austinhyde/ansible-sshjail) to provide streamlined connections to defined jail inventory.

To install ansible-sshjail connection plugin, make it available to the provisioning playbooks like this:

```bash
mkdir provisioning/connection_plugins
curl -o provisioning/connection_plugins/sshjail.py https://raw.githubusercontent.com/austinhyde/ansible-sshjail/master/sshjail.py
```

# Using webdevj1

With dependencies installed you can vagrant up the box:

```bash
$ vagrant up
```

And then you can SSH to the jailhost VM with:

```bash
$ vagrant ssh jailhost
```

For examples of how the networking comes together, to hit a webserver jail you would browse to the jails IP as defined in jails.yml. e.g. http://10.0.5.21/

```bash
nc -v -z 10.0.2.21 80
```

Similarly, to talk to the redis jail you would talk to its IP on 

```bash
nc -v -z 10.0.2.31 6379

redis-cli -h 10.0.2.31 -n 0
redis 10.0.5.31:6379> ping
PONG
```


# Frequently Asked Questions

Q: When developing jails for my purposes, do I need to provision the jailhost from scratch every time?
A: No, jail provisioning is designed to be efficiently reentrant. To start from scratch for a specific jail, delete your mal-performing jail with:

```bash
vagrant ssh jailhost
sudo service ezjail stop redis00
sudo ezjail-admin delete redis00
sudo rm -rf /opt/jails/redis00
```

Replace redis00 with the name of the jail you want to be re-provisioned from scratch and then `vagrant provision` again from your vagrant host.
