# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.network "private_network", type: "dhcp"

  config.vm.define "web", primary: true do |web|
    web.vm.provider "vmware_desktop" do |v| 
      v.cpus = 2
      v.memory = "3000"
    end

    web.vm.network "forwarded_port", guest: 80, host: 8080
    web.vm.network "forwarded_port", guest: 5432, host: 6432

    web.vm.network "private_network", ip: "192.168.100.10"
    web.vm.provision "shell", path: "install_puppet_server.sh"
  end

  config.vm.define "node1" do |node1|
    node1.vm.provider "vmware_desktop" do |v| 
      v.cpus = 2
      v.memory = "2000"
    end

    node1.vm.network "private_network", ip: "192.168.100.20"
    node1.vm.provision "shell", path: "install_puppet_node.sh"
  end


  if Vagrant::Util::Platform.darwin?
    config.vm.box = "bento/ubuntu-22.04-arm64"
  else
    config.vm.box = "ubuntu/jammy64"
    config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install virtualbox-guest-x11 -y"
  end

  config.vm.provision "shell", path: "boostrap.sh"

  config.vm.synced_folder ".", "/vagrant"
  config.vm.synced_folder "./docker", "/home/vagrant/docker"
end