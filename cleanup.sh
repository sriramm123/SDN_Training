#!/bin/bash
sudo ip link del dev br0
sudo ip netns exec peach ip link delete peach2net
sudo ip link delete bowser2net
sudo ip netns del mario
sudo ip netns del peach
sudo ip netns del bowser
