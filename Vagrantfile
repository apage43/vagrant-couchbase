# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.network :forwarded_port, guest: 8091, host: 8091
  config.vm.network :forwarded_port, guest: 8092, host: 8092
  config.vm.network :forwarded_port, guest: 11211, host: 11211
  config.vm.network :forwarded_port, guest: 11210, host: 11210

  # 1024M ram on virtualbox
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end
end
