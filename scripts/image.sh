#!/bin/bash

# Creates a bootable disk image from a kernel image
# Usage:
#    image.sh kernel_name image_name

#
#  Private Impl
#

image() {
  local kernel_file = "$1"
  local image_file = "$2"

  # Create a zeroed out disk image file
	dd if=/dev/zero of=$(IMG_FILE) bs=512 count=32768
  # Add a Master Boot Record (MBR) to the image
	dd parted $(IMG_FILE) mklabel msdos
  # Add a FAT32 partition to the image
	parted $(IMG_FILE) mkpart primary fat 2048s 30720s
  # Set the partition boot flag
	parted $(IMG_FILE) set 1 boot on
  # Identify the next two free loopback block devices
  N=$(losetup -f | grep -o '[0-9]*$')
  LOOP_DEVICE1="/dev/loop$N"
  LOOP_DEVICE2="/dev/loop$((N+1))"

}