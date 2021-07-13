#!/bin/bash
#lab 16

# create an OvS bridge 
sudo ovs-vsctl add-br bridge-wario
sudo ovs-vsctl add-br bridge-yoshi

# create network namespaces
sudo ip netns add wario &> /dev/null
sudo ip netns add yoshi &> /dev/null

# create bridge internal interface
sudo ovs-vsctl add-port  bridge-wario wario -- set interface wario type=internal

# plug the OvS bridge internals into the wario
sudo ip link set wario netns wario

# bring interface UP in wario
sudo ip netns exec wario ip link set dev wario up
sudo ip netns exec wario ip link set dev lo up 

# add IP address to interface
sudo ip netns exec wario ip addr add 10.64.0.10/24 dev wario

# create VETH
sudo ip link add yoshi2bridge type veth peer name bridge2yoshi &> /dev/null

# plug in VETH to namespace
sudo ip link set yoshi2bridge netns yoshi &> /dev/null

# add IP address assignments
sudo ip netns exec yoshi ip a add 10.64.0.11/24 dev yoshi2bridge &> /dev/null

# make all connections UP
sudo ip netns exec yoshi ip link set dev yoshi2bridge up &> /dev/null
sudo ip netns exec yoshi ip link set dev lo up &> /dev/null

# plung bridge2yoshi to bridge-yoshi

sudo ovs-vsctl add-port bridge-yoshi bridge2yoshi

# bringing up the ovs-patchsudo ovs-vsctl list-ports 

sudo ovs-vsctl add-port bridge-wario wario-port -- set interface wario-port type=patch options:peer=yoshi-port
sudo ovs-vsctl add-port bridge-yoshi yoshi-port -- set interface yoshi-port type=patch options:peer=wario-port


