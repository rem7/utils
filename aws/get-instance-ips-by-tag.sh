#!/bin/bash

TAGS=$1

aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$TAGS" \
    --region us-west-2 \
    | jq -r "\
    .Reservations[] | \
    .Instances[] | \
    .NetworkInterfaces[] | \
    .Association | \
    .PublicIp"

