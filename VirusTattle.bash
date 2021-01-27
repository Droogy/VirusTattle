#!/bin/bash

# checks for -f and then runs in file mode if so
if [ "$1" == "-f" ]; then
	read -p "gib bad file: " badfile
	printf "\n[*] Uploading $badfile...\n"
	# VT api call for file upload > 32MB
	curl -s --request POST \
		--url https://www.virustotal.com/api/v3/files \
		--header "x-apikey:"$API_KEY \
		--form file=@"/"$PWD"/"$badfile \
		-o id.json
	
	# get id we need for analysis
	jq -r .data.id id.json > id.txt
	# read id into variable
	bad_id=$(<id.txt)
	printf "\n[*] $badfile uploaded okay, VT id is $bad_id\n"
	printf "\n[*] Analyzing $badfile...\n\n"
	sleep 20
	
	# VT api call for analysis
	curl -s --request GET \
		--url https://www.virustotal.com/api/v3/analyses/$bad_id \
          	--header "x-apikey:"$API_KEY \
	 	-o results.json
	# pretty print results
	jq . results.json	
exit
else
	read -p "gib bad url: " badurl
	
	curl -s --request POST \
		--url https://www.virustotal.com/api/v3/urls \
		--header "x-apikey:"$API_KEY \
		--form url=$badurl \
		-o id.json
	
	printf "\n[*] $badurl uploaded to VT\n"
	jq -r .data.id id.json > id.txt
	bad_id=$(<id.txt)
	printf "\n[*] VT id for $badurl is: $bad_id"
	printf "\n[*] Analyzing $badurl...\n"
	sleep 20

	curl -s --request GET \
		--url https://www.virustotal.com/api/v3/analyses/$bad_id \
		--header 'x-apikey:'$API_KEY \
		-o results.json

	jq . results.json
fi