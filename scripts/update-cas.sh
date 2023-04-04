#!/bin/bash
# script to download TrustedCertificateAuthority 
# make sure to update /etc/ssh/sshd_config and add:
# TrustedUserCAKeys /etc/ssh/cas.pub
# bash <(curl -s https://raw.githubusercontent.com/rem7/utils/main/scripts/update-cas.sh)

dir=$(mktemp -d)
echo $dir

gpg --keyserver keyserver.ubuntu.com --recv-keys 047BC46E1CE0AA53927D92002A1633C650997C84
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi

curl -L yanko.pub/cas.pub | gpg --output - --verify > $dir/cas.pub
if [ $? -ne 0 ]; then
    echo ". unable to download and verify public ssh keys"
    exit -1
fi

install -o $USER -g $USER -m 0644 $dir/cas.pub /etc/ssh/cas.pub

rm -rf $dir
exit 0
