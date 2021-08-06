source ./functions.sh;

# Generate FSTAB
STEP="Generate FSTAB Step";
genfstab -U -p /mnt ＞ /mnt/etc/fstab;
stop_if_previous_failed;
echo "Time to see the fstab";