#! /usr/bin/env bash

apt-get update

# make sure we get a good nodejs version
apt-get install -y python-software-properties python g++ make
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install nodejs

apt-get install -y git vim

git clone https://github.com/thlorenz/dotfiles.git
chown -R vagrant:vagrant dotfiles

echo 'LANG=en_US.UTF-8' > /etc/default/locale

rm -f .bashrc .profile

# during provisioning ~ or $HOME seems to be /root so we need to fix that
export HOME=`pwd`

./dotfiles/scripts/create-links.sh

( cd ./dotfiles &&               \
  git submodule update --init && \
  rm -rf vim/bundle/powerline && \
  git clone https://github.com/bling/vim-airline.git vim/bundle/airline)

# start our node app
# (cd /vagrant && npm start)
