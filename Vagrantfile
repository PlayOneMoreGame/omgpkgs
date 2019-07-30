# -*- mode: ruby -*-
# vi: set ft=ruby :

# VM Configurations to install and test the base development environment.

$setup = <<-SCRIPT
#!/usr/bin/env bash
set -euo pipefail

rm -Rdf $HOME/src
mkdir -p $HOME/src
cd /mnt/src
git ls-files -z | xargs -0 -i cp --parents {} $HOME/src
cd $HOME/src
bin/setup.sh
SCRIPT

$test = <<-SCRIPT
#!/usr/bin/env bash
set -euo pipefail

if ! command -v direnv &> /dev/null; then
  exit 1
fi
SCRIPT

Vagrant.configure("2") do |config|
  config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/mnt/src"

  config.vm.provision "setup", type: "shell" do |p|
    p.inline = $setup
    p.privileged = false
  end

  config.vm.provision "test", type: "shell" do |p|
    p.inline = $test
    p.privileged = false
  end

  config.vm.define "ubuntu1904" do |v|
    v.vm.box = "generic/ubuntu1904"
    v.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "2048"
    end
  end
end
