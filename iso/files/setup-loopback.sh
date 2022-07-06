#!/bin/bash
set -e
/usr/bin/systemctl start NetworkManager
/usr/bin/nmcli connection add type dummy ifname k3s-lo ipv4.method manual ipv4.addresses 100.64.0.1/32 ipv6.method ignore connection.zone internal
/usr/bin/nmcli connection up dummy-k3s-lo
