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

# USAGE: array_join ${ARRAY_NAME[@]}
array_join() {
    local TO_RETURN="";

    for ITEM in $@
    do
        TO_RETURN="$TO_RETURN $ITEM";
    done

    echo $TO_RETURN;
}