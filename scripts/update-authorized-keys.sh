#!/bin/bash

# script replaces $user/authorized_keys when it runs
# set it up on cron for every hour
# 7 * * * * /home/rem7/update-authorized-keys.sh rem7

dir=$(mktemp -d)
echo $dir

gpg --keyserver keyserver.ubuntu.com --recv-keys 047BC46E1CE0AA53927D92002A1633C650997C84
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi

curl -L yanko.pub | gpg --output - --verify > $dir/yanko.pub
if [ $? -ne 0 ]; then
    echo ". unable to download and verify public ssh keys"
    exit -1
fi

install -o $USER -g $USER -m 0644 $dir/yanko.pub /home/$USER/.ssh/authorized_keys

rm -rf $dir
exit 0

