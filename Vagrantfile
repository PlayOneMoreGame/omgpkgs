# -*- mode: ruby -*-
# vi: set ft=ruby :

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
  config.vm.box = "generic/ubuntu1904"
  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "2048"
  end
  config.vm.provision "setup", type: :shell, inline: $setup, privileged: false
  config.vm.provision "test", type: :shell, inline: $test, privileged: false
  config.vm.synced_folder ".", "/mnt/src"
end
