#!/usr/bin/env ruby

# -*- mode: ruby -*-
# vi: set ft=ruby :

SHELL_PROVISION = <<-HEREDOC
apt-get update -qq;
service docker stop;
apt-get install -qy --force-yes lxc-docker python-software-properties;
add-apt-repository -y ppa:brightbox/ruby-ng-experimental;
apt-get update -qq;
apt-get install -y ruby2.0 ruby2.0-dev ruby2.0-doc;
update-alternatives \
  --install /usr/bin/ruby ruby /usr/bin/ruby2.0 500 \
  --slave /usr/bin/erb erb /usr/bin/erb2.0 \
  --slave /usr/bin/irb irb /usr/bin/irb2.0 \
  --slave /usr/bin/rdoc rdoc /usr/bin/rdoc2.0 \
  --slave /usr/bin/ri ri /usr/bin/ri2.0 \
  --slave /usr/bin/rake rake /usr/bin/rake2.0;
HEREDOC

def machine_exists?
  !Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?
end

Vagrant::Config.run do |config|
  config.vm.box = "precise-64-docker"
  config.vm.box_url = "http://bit.ly/dockerprecise64"
  config.ssh.forward_agent = true

  unless machine_exists?
    config.vm.provision :shell, :inline => SHELL_PROVISION
  end
end
