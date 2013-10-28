#!/bin/bash

ip=$(ip addr | grep eth0 | grep inet | awk '{print $2}' | cut -f1 -d"/")

serf agent -role=deployer -bind=$ip
