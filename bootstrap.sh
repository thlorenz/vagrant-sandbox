#! /usr/bin/env bash

apt-get update

# make sure we get a good nodejs version
apt-get install -y python-software-properties python g++ make
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs

apt-get install -y clang

# C tooling - needed already just to install things like silver_searcher from source
apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev

# setup nodejs and npm
mkdir npm-global
npm config set prefix ./npm-global

# vim and related tooling

## I know this is huge, but I want python support for my cute little plugins damnit!
apt-get install -y git vim-gnome

## clang-complete support
apt-get install -y exuberant-ctags libclang-dev

## syntastic support for javascript
npm install -g jshint

# utils

## cat files syntax highlighted via `c` command
apt-get install -y python-pygments

## silver_searcher from source
git clone https://github.com/ggreer/the_silver_searcher.git
(cd the_silver_searcher && ./build.sh && make install)
rm -rf the_silver_searcher

# my dotfile setup
git clone https://github.com/thlorenz/dotfiles.git
chown -R vagrant:vagrant dotfiles

echo 'LANG=en_US.UTF-8' > /etc/default/locale

rm -f .bashrc .profile

# during provisioning ~ or $HOME seems to be /root so we need to fix that
export HOME=`pwd`

./dotfiles/scripts/create-links.sh
cp -R ./dotfiles/fonts /usr/share/

(cd ./dotfiles &&  git submodule update --init)

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
