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

And then SSH to the jailhost VM with:

```bash
$ vagrant ssh jailhost
```
