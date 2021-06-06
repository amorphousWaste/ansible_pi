#!/bin/bash

# This script is meant to run as a cron task to keep network connections
# alive.

# Attempt to ping the router twice.
ping -c2 192.168.50.1

if [ $? != 0 ]; then
    printf "Could not ping router; restarting wlan0..."
    ifconfig wlan0 down
    sleep 5
    ifconfig wlan0 up
else
    printf "Ping successful."
fi
