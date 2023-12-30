# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  if Vagrant::Util::Platform.darwin?
    config.vm.box = "bento/ubuntu-22.04-arm64"
  else
    config.vm.box = "ubuntu/jammy64"
    config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y virtualbox-guest-x11"
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 5432, host: 6432

  config.vm.synced_folder ".", "/vagrant"
  config.vm.synced_folder "./docker", "/home/vagrant/docker"

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host

  config.vm.provider "vmware_desktop" do |v| 
    v.cpus = 2
    v.memory = "4000"
  end

  # View the documentation for the provider you are using for more

  config.vm.provision "shell", path: "install.sh"
  config.vm.provision "shell", path: "boostrap.sh"

end
