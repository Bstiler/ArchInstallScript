SCRIPT_DIR=`cd \`dirname $0\` && pwd`;
source $SCRIPT_DIR/env-check.sh;

# Set up home folder

# Creates what will become the home Folder
# takes an argument with the installation name
# if none is given 'arch' is used
create_home() {
    if [ ! $1 ]
    then
        INSTALATION_NAME=arch
    else
        INSTALATION_NAME=$1
    fi

    STEP="Set Up Home Folder Step";
    export FINAL_HOME=/mnt/media/$USERNAME/home/$INSTALATION_NAME;
    mkdir /mnt/media/$USERNAME/home/$INSTALATION_NAME;
}
