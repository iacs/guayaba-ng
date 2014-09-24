VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.define :io do |m|
  end
  config.vm.provider "virtualbox" do |v|
    v.name = "Io"
    v.memory = 512
  end
  config.vm.network :forwarded_port, host: 4000, guest: 4000
  config.vm.synced_folder "salt/", "/srv/"
  config.vm.hostname = "io"
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.colorize = true
  end
end