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
  local arch = $(uname -m)
  # Create a zeroed out disk image file
	dd if=/dev/zero of=$(image_file) bs=512 count=32768
  # Add a Master Boot Record (MBR) to the image
	dd parted $(image_file) mklabel msdos
  # Add a second extended file system (ext2) partition to the image
	parted $(image_file) mkpart primary ext2 2048s 30720s
  # Set the partition boot flag
	parted $(image_file) set 1 boot on
  # Identify the next two free loopback block devices
  N=$(losetup -f | grep -o '[0-9]*$')
  LOOP_DEVICE1="/dev/loop$N"
  LOOP_DEVICE2="/dev/loop$((N+1))"
  # Setup the loopback devices
  # The entire image
  sudo losetup $(LOOP_DEVICE1) $(image_file)
  # The partition (offset = 2048 sectors * 512 bytes = 1048576 bytes)
  sudo losetup $(LOOP_DEVICE2) $(image_file) -o 1048576
  # Format the partition as FAT32
  sudo mkfs.ext2 $(LOOP_DEVICE2)
  # Create a mount point for the file system
  mkdir -p /mnt/osfiles
  # Mount the partition
  sudo mount $(LOOP_DEVICE2) /mnt/osfiles
  if [ "$arch" = "x86_64" ]; then
    # Install GRUB in the MBR
    sudo grub-install --root-directory=/mnt/osfiles --no-floppy --modules="normal part_msdos ext2 multiboot" $(LOOP_DEVICE1)
  else
    # Install GRUB in the MBR from another architecture
    sudo ~/opt/cross-kernel/sbin/grub-install --root-directory=/mnt/osfiles --target=i386-pc --no-floppy --modules="normal part_msdos ext2 multiboot" $(LOOP_DEVICE1)
  fi
  # Copy files to the image
  sudo cp -r $(kernel_file)/* /mnt/osfiles
  # Unmount the partition
  sudo umount /mnt/osfiles
  # Remove the block devices
  sudo losetup -d $(LOOP_DEVICE1)
  sudo losetup -d $(LOOP_DEVICE2)
}

# Main script logic
if [ $# -eq 2 ]; then
  if [ ! -f "$1" ]; then
    echo "Error: $1 does not exist"
    exit 1
  fi
  if [ -f "$2" ] && [ ! -w "$2" ]; then
    echo "Error: $2 is not writable"
    exit 1
  fi
  image "$1" "$2"
else
  echo "Usage: $0 kernel_file image_file"
  exit 1
fi
