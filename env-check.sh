SCRIPT_DIR=`cd \`dirname $0\` && pwd`;
source $SCRIPT_DIR/env-setup.sh;

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

if [ ! $MAIN_PASSWORD ]
then
echo "Password variable not found. Please define one at the \$MAIN_PASSWORD variable.";
exit;
fi