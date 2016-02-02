FROM ubuntu:12.04

# make sure everything is up to date
RUN apt-get update

# install bind and curl
RUN apt-get install -y bind9 bind9utils curl

# customised config to be a DNS forwarder
ADD named.conf.options.template /etc/bind/named.conf.options.template
# start script to template in VPC DNS IP
ADD startdns.sh /startdns.sh

EXPOSE 53/udp

CMD ["/bin/bash", "/startdns.sh"]
