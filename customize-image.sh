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

	# Remove first login setup
	rm /root/.not_logged_in_yet
	usermod -p "$y$j9T$xaMA4if3koVWt.ufxLrS50$fyBx2ZQZoDLlS5mu7ZVJsMQFm6AdZIp9KkGMOuS4XN4" root

	# Install required packages
	apt-get update
	apt-get install -y vim seatd weston chromium

	# Create weston configuration directory
	mkdir -p /etc/xdg/weston
	
	# Copy weston.ini configuration file
	cp /tmp/overlay/weston.ini /etc/xdg/weston/weston.ini
	
	# Copy browser launch script and make it executable
	cp /tmp/overlay/divera.sh /usr/local/bin/divera.sh
	chmod +x /usr/local/bin/divera.sh
	
	# Copy systemd service for auto-starting weston
	cp /tmp/overlay/weston.service /etc/systemd/system/weston.service

	# Enable the service
	systemctl enable weston.service
	
} # Main

Main "$@"
