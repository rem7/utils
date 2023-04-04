#!/bin/bash
#
# bash <(curl -s https://raw.githubusercontent.com/rem7/utils/master/scripts/add-user-deb.sh yanko)

adduser --disabled-password --gecos "" -q $1
usermod -a -G admin $1
sudo -u $1 mkdir ~$1/.ssh
sudo -u $1 chmod 755 ~$1/.ssh
sudo -u $1 gpg --keyserver keyserver.ubuntu.com --recv-keys 047BC46E1CE0AA53927D92002A1633C650997C84
sudo -u $1 bash -c 'curl -L https://yanko.pub | gpg --output - --verify > ~$1/.ssh/authorized_keys'
bash -c 'echo "%admin ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/91-admin'
chmod 0440 /etc/sudoers.d/91-admin
