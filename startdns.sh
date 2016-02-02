#!/bin/bash
MAC="$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/)"
VPCCIDR="$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/"$MAC"/vpc-ipv4-cidr-block)"
VPCNET="${VPCCIDR%%/*}"
VPCBASE="$(echo "$VPCNET" | cut -d"." -f1-3)"
VPCDNS="$VPCBASE"'.2'
sed s/DNSIP/"$VPCDNS"/ /etc/bind/named.conf.options.template \
  > /etc/bind/named.conf.options
/usr/sbin/named -u bind -g
