#!/bin/sh

stop_if_fail() {
	eval $*;
	if [ ! $? -eq 0 ]
	then
		echo "The $STEP failed.";
		echo "The specific command that failed was: $*";
		exit;
	fi
}

stop_if_previous_failed() {
    if [ ! $? -eq 0 ]
	then
		echo "The $STEP failed.";
		echo "The specific command that failed was: $*";
		exit;
	fi
}

#First parameter is the variable name and ethe second is its value
add_post_install_var() {
	local POST_INSTALL_VARS_TMP_FILE=/tmp/postinstall-vars.sh;
	touch $POST_INSTALL_VARS_TMP_FILE;
	echo "export $1=$2;" >> $POST_INSTALL_VARS_TMP_FILE;
}