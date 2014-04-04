# vagrant

Playing with vagrant and docker -- that's all.


## Steps to play along
    
    git fetch --all
    git checkout docker

    # stand up our initial box and get all our things installed
    vagrant up

    # the box will reboot since it upgrades your linux kernel to support the aufs file system

    # at this point we can 'vagrant ssh' into your box to install docker run via a script that was prepared
    sudo sh ./install-docker.sh

    # if you are like me and want to launch docker manually do the following
    sudo rm -rf /etc/init/docker.conf
    sudo reboot

    # now you can manually start it after loggin in again via
    docker -d

    # note that in this setup docker is aliased to listen via http instead a unix file socket i.e. try
    alias docker 
