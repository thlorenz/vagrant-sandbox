#! /usr/bin/env bash

apt-get update
apt-get install -y nodejs npm git vim

git clone https://github.com/thlorenz/dotfiles.git
chown -R vagrant:vagrant dotfiles

rm -f .bashrc .profile

# during provisioning ~ or $HOME seems to be /root so we need to fix that
export HOME=`pwd`

./dotfiles/scripts/create-links.sh

(cd ./dotfiles && git submodule update --init)

# start our node app
# (cd /vagrant && npm start)
