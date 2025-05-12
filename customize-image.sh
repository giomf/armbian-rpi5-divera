#!/bin/bash

# arguments: $RELEASE $LINUXFAMILY $BOARD $BUILD_DESKTOP
#
# This is the image customization script

# NOTE: It is copied to /tmp directory inside the image
# and executed there inside chroot environment
# so don't reference any files that are not already installed

# NOTE: If you want to transfer files between chroot and host
# userpatches/overlay directory on host is bind-mounted to /tmp/overlay in chroot
# The sd card's root path is accessible via $SDCARD variable.

RELEASE=$1
LINUXFAMILY=$2
BOARD=$3
BUILD_DESKTOP=$4

Main() {
	# Install required packages
	apt-get update
	apt-get install -y weston chromium

	# Create weston configuration directory
	mkdir -p /etc/xdg/weston
	
	# Copy weston.ini configuration file
	cp /tmp/overlay/weston.ini /etc/xdg/weston/weston.ini
	
	# Copy browser launch script and make it executable
	cp /tmp/overlay/launch-browser.sh /usr/local/bin/launch-browser.sh
	chmod +x /usr/local/bin/launch-browser.sh
	
	# Copy systemd service for auto-starting weston
	cp /tmp/overlay/weston.service /etc/systemd/system/weston.service

	# Enable the service
	systemctl enable weston.service
	
} # Main

Main "$@"
