#!/bin/bash

domain=$1
zone_id=$2
api_key=$3

generate_payload() 
{
    cat <<EOF
{"name": "$domain", "hosted_zone_id": "$zone_id", "api_key":"$api_key"}
EOF
}

remote_ip=$(dig +noall +answer $domain @1.1.1.1 | awk '{print $5}' | tr -d '[:space:]')
echo $remote_ip

local_ip=$(curl -4 -s http://ident.me )
echo $local_ip

if [ "$local_ip" = "$remote_ip" ]; then
    echo "domain is current. no update needed."
    exit 0
else
    echo "domain needs to be updated."
fi

/usr/bin/curl -i -H 'content-type: application/json' 'https://LAMBDA_URL.lambda-url.us-west-2.on.aws/' -d "$(generate_payload)"


