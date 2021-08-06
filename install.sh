#!/bin/sh

# Step 1: Config some misc stuff
echo "Initial Setup Started";
source ./env-check.sh;
source ./initial-setup.sh;

# Step 2: Setup Root filesystem
source ./rootfs.sh;
set_root_as_btrfs $ROOTFS;

# Step 3: Mount partitions
source ./mount.sh;

# BTRFS swapfile setup
source ./swapfile.sh;
set_up_swapfile 1024;

# Set up home folder
source ./home.sh;
create_home;

# Install Base System
source ./base.sh;

# Generate FSTAB
source ./fstab.sh;

# Create Sub-script

source ./chroot-script-generator.sh
