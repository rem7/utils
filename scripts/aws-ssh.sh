#!/bin/bash

AWS_REGION=us-west-2
AWS_ACCESS_KEY_ID=XXX
AWS_SECRET_ACCESS_KEY=XXX
LAMBDA_URL=https://qwerty.lambda-url.us-west-2.on.aws/

pubkey=`cat /etc/ssh/ssh_host_rsa_key.pub | awk '{print $1 " " $2}'`

jo -p expire=10d \
	host_user=zfs-nas \
	key_type=host \
	public_key="$pubkey" \
	principal_list=$(jo -a "hostname1.example.com" "hostname2.example.com") |
	curl --aws-sigv4 "aws:amz:us-west-2:lambda" --user $AWS_ACCESS_KEY_ID:$AWS_SECRET_ACCESS_KEY \
	--json @- $LAMBDA_URL

