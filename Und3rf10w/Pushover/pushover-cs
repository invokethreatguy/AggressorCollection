#!/bin/bash 
if [[ $# -gt 0 ]]; then 
	title=$1
	shift
	a=$@ 
else 
	read a; 
fi

pushover () {
	curl -s -F "token=$1" -F "user=$2" -F "title=$3" -F "message=$a" https://api.pushover.net/1/messages.json
}

# sample pushover user config
# add a line for each user you wish to receive a message
# pushover <app_token> <user_token> "$title" "$a" #sample_username1
