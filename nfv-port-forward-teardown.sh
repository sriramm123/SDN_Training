#!/usr/bin/bash

sudo ip netns del bowser
sudo ip netns del peach
sudo ip netns del mario
sudo ip netns del yoshi
sudo ip netns del router

sudo ovs-vsctl del-br donut-plains

sudo iptables -P FORWARD DROP && sudo iptables -F FORWARD && sudo iptables -t nat -F
Execute your script.


