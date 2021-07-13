#!/bin/bash
# TEARDOWN

# delete bridges
sudo ovs-vsctl del-br bridge-wario &> /dev/null
sudo ovs-vsctl del-br bridge-yoshi &> /dev/null

# remove VETH
sudo ip netns exec yoshi ip link delete yoshi2bridge &> /dev/null

# delete network namespaces
sudo ip netns del wario &> /dev/null
sudo ip netns del yoshi &> /dev/null
