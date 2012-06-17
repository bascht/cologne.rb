# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.name = "colognerb"
  config.vm.box = "base"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  config.vm.customize ["modifyvm", :id, "--memory", "512"]
  config.vm.customize ["modifyvm", :id, "--cpus", "2"]

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  config.dns.tld = "dev"
  config.vm.host_name = "cologne.onruby"

  config.vm.network :hostonly, "33.33.33.42"
  # config.vm.forward_port "http", 80, 8080

 config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
 #   puppet.options = "--verbose --debug"
  end
end
