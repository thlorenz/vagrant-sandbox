#! /usr/bin/env bash

apt-get update

# make sure we get a good nodejs version
apt-get install -y python-software-properties python g++ make
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs

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

# docker

## https://github.com/dotcloud/docker/issues/4568#issuecomment-37259489 
apt-get install -y cgroup-lite

## upgrade linux kernel to support aufs
apt-get install -y linux-image-generic-lts-raring linux-headers-generic-lts-raring

## not sure if we could install docker before upgrading kernel, so we'll reboot first and do it after
echo 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9' > ./install-docker.sh
echo 'sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"'   >> ./install-docker.sh 
echo 'apt-get update'                                                                                   >> ./install-docker.sh
echo 'apt-get install -y lxc-docker'                                                                    >> ./install-docker.sh

echo "rebooting to activate new linux kernel please run 'sudo sh ./install-docker.sh' after logging in again"

# start our node app
# (cd /vagrant && npm start)
