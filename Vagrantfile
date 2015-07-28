# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.host_name = "vagrant-blog.local"
  config.vm.box = "ubuntu/trusty64"

  # Required for NFS to work, pick any local IP
    config.vm.network :private_network, ip: '10.1.1.10'
    config.ssh.forward_agent = true

    config.vm.network :forwarded_port, guest: 8080, host: 8081, auto_correct: true
    config.vm.network :forwarded_port, guest: 4000, host: 5000, auto_correct: true
    config.vm.network :forwarded_port, guest: 22, host: 2200, auto_correct: true
    config.vm.synced_folder "/home/wingston/scrap/wingie.github.com/", "/blog/", nfs: true
    config.vm.provider :virtualbox do |vb|
       vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/project", ""]
    end
    
    config.vm.provision :shell, path: "bootstrap.sh"
    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"

   config.vm.provider "virtualbox" do |v|
     host = RbConfig::CONFIG['host_os']

     # Give VM 1/4 system memory & access to all cpu cores on the host
     if host =~ /darwin/
       cpus = `sysctl -n hw.ncpu`.to_i
       # sysctl returns Bytes and we need to convert to MB
       mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
     elsif host =~ /linux/
       cpus = `nproc`.to_i
       # meminfo shows KB and we need to convert to MB
       mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
     else # sorry Windows folks, I can't help you
       cpus = 2
       mem = 1024
     end

     v.customize ["modifyvm", :id, "--memory", mem]
     v.customize ["modifyvm", :id, "--cpus", cpus]
   end
end
