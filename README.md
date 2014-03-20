# vagrant

Playing with vagrant -- that's all.


## Steps to play along
    
    git checkout package

    vagrant box add hashicorp/precise32

    # stand up our initial box and get all our things installed
    vagrant up

    # at this point we can 'vagrant ssh' into your box

    # in order to not have to run the installations all the time we'll create a package
    vagrant package --output node-vim-dotfiles.box

    # add it so we can use it in future Vagrantfiles
    vagrant box add node-vim-dotfiles.box  --name node-vim-dotfiles

    # checkout the version in which we simplified the bootstrap script and are using our custom box in the Vagrantfile
    git checkout first-app

    # since our box is still up, we just need to provision it again to get it to bootstrap again
    vagrant provision

    # alternatively we could destroy/up to get totally fresh box
    vagrant destroy
    vagrant up

    # at this point we can access our app at http://localhost:42222/
