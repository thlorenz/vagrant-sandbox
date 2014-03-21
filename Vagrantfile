# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "node-vim-dotfiles"

  (0..2).each do |i| 
    config.vm.define "slave-#{i}" do |slave|
      slave.vm.network :forwarded_port, host: 42222 + i, guest: 3000
      slave.vm.provision "shell", inline: "echo launching slave #{i}"
    end
  end
end
