#!/bin/bash

#set -e

if [ $# -eq 1 ]; then
    currentWorkspace=$(i3-msg -t get_workspaces \
        | jq '.[] | select(.focused==true).name' \
        | cut -d"\"" -f2)
    
    if [ $currentWorkspace -eq $1 ]; then
        echo "Cannot swap with same Workspace" >&2

	exit 1
    else
	echo "Swapping Workspace $currentWorkspace with $1"
	i3-msg "rename workspace $currentWorkspace to temporary; rename workspace $1 to $currentWorkspace; rename workspace temporary to $1"
    fi
else
    echo "Wrong argument" >2

    exit 1
fi

exit 0
