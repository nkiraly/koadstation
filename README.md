# koadstation

koadstation is a collection of development environments, and servers that I use in my systems engineering on a regular basis. I hope that these provisioning tools benefit you in your software engineering adventures.

# stations

- tiledraweru14 - Ubuntu 14.04 LTS map tile server
- webdevf1 - FreeBSD 10.1 web development environment
- webdevj1 - FreeBSD 10.1 jailed web development environment, uses [ansible-sshjail](https://github.com/austinhyde/ansible-sshjail) to streamline ansible interactions
- dbdevf2 - FreeBSD 10.2 database development environment
- dbdevf3 - FreeBSD 10.3 database development environment


# Frequently Asked Questions

Q: Is windows supported as a vagrant host?

A: These stations target both linux and windows as vagrant hosts, with the virtualbox provider.


Q: What is the recommended way of running these stations on windows?

A: The most streamlined approach for provisioning is to use GitHub for windows shell as it will make vagrant, ssh, curl etc work without any additional configuration. For full shell administration though, PuTTY is recommended to connect to the stations' forwarded SSH port.
