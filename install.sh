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
mount_stuff;

# Set up home folder
source ./home.sh;
create_home;

# Install Base System
source ./base.sh;

# Generate FSTAB
source ./fstab.sh;
generate_fstab;

# Set up postinstall scripts

source ./setup-postinstall.sh;
ignite_postinstall;
