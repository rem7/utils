#!/bin/bash

docker pull sissbruecker/linkding
docker run --name linkding --rm -p 9090:9090 -v /var/lib/linkding-bookmarks:/etc/linkding/data sissbruecker/linkding:latest
