
source ./env-setup.sh;

if [ ! $ROOTFS ]
then
echo "Root filesystem partition variable not found, define \$ROOTFS with a valid partition.";
exit;
fi

if [ ! $EFIFS ]
then
echo "EFI filesystem partition variable not found, define \$EFIFS with a valid partition.";
exit;
fi

if [ ! $HOMEFS ]
then
echo "EFI filesystem partition variable not found, define \$EFIFS with a valid partition.";
exit;
fi

if [ ! $USERNAME ]
then
echo "Username variable not found. Please define one at the \$USERNAME variable.";
exit;
fi

if [ ! $HOSTNAME ]
then
echo "Host name variable not found. Please define one at the \$HOSTNAME variable.";
exit;
fi
