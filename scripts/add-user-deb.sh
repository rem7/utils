#!/bin/bash
#
# bash <(curl -s https://raw.githubusercontent.com/rem7/utils/master/scripts/add-user-deb.sh yanko)

adduser --disabled-password --gecos "" -q rem7
usermod -a -G admin rem7
sudo -u rem7 mkdir ~rem7/.ssh
sudo -u rem7 chmod 755 ~rem7/.ssh
sudo -u rem7 gpg --keyserver keyserver.ubuntu.com --recv-keys 047BC46E1CE0AA53927D92002A1633C650997C84
sudo -u rem7 bash -c 'curl -L https://yanko.pub | gpg --output - --verify > ~rem7/.ssh/authorized_keys'
bash -c 'echo "%admin ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/91-admin'
chmod 0440 /etc/sudoers.d/91-admin
