#!/bin/bash

# =================================================================
# Name		: DoorbellListener
# Author	: N3tMonk
# Version	: v1.0 (2018/10/03)
# =================================================================

# Configure GPIO
GPIOPin="18"
GPIOState="1"
GPIODirection="out"
SleepTime="1"

# Checking the current state of the specified GPIO-pin and
# configure it if needed.
if [ ! -d "/sys/class/gpio/gpio$GPIOPin" ]; then
  	echo "Configuring GPIO$GPIOPin."
  	echo "$GPIOPin" > /sys/class/gpio/export
  	echo "$GPIODirection" > /sys/class/gpio/gpio$GPIOPin/direction
  	echo "$GPIOState" > /sys/class/gpio/gpio$GPIOState/value
  	echo "GPIO$GPIOPin is now configured. Listening now."
elif [ -d "/sys/class/gpio/gpio$GPIOPin" ]; then
	echo "GPIO$GPIOPin already configured. Listening now."
else
	echo "Can't check or create the current GPIO settings. Stopping."
	exit 1
fi

# Loop for checking the status of the specified GPIO-pin.

while true; do	
	if [ "$(cat /sys/class/gpio/gpio$GPIOPin/value)" = "0" ]; then
		echo "There is someone at the door."
		sleep $SleepTime
	fi
done

