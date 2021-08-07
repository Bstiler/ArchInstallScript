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
