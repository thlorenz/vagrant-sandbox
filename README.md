# vagrant

Playing with vagrant -- that's all.


## Steps to play along
    
    git checkout package

    # optional - will be added automatically when we do 'vagrant up'
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

## Multiple Slaves

```sh
git checkout slaves
./run.sh
```

This will create a machine for each slave and run them all, logging to separate log file for each.

The `Vagrantfile` was updated go spawn multiple slaves:

```ruby
(0..2).each do |i| 
  config.vm.define "slave-#{i}" do |slave|
    slave.vm.network :forwarded_port, host: 42222 + i, guest: 3000
    slave.vm.provision "shell", inline: "echo launching slave #{i}"
  end
end
```

The `up.sh` script takes care of creating the VMs and starting them. I was unable to figure out how to start
multiple servers via a boot script launched from `Vagrantfile` since the first one will block and prevent other slaves
from starting up.

Therefore we do this manually inside the `up.sh` script via:

    vagrant ssh slave-$i -c "sudo killall node && cd /vagrant && SLAVE_ID=$i npm start" &> slave-$i.log &

We pipe the output to a log file which we then `tail` on:

    tail -f slave-0.log -f slave-1.log -f slave-2.log
