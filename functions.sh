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

error_tolerant_pacman() {
	eval $*;
	if [ ! $? -eq 0 ]
	then
		rm -rf /var/lib/pacman/sync;
		pacman -Syy;
		eval $*;
	fi
}

error_tolerant_pacstrap() {
	eval $*;
	if [ ! $? -eq 0 ]
	then
		rm -rf /mnt/var/lib/pacman/sync;
		pacman -Syy;
		eval $*;
	fi
}