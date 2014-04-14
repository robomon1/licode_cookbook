#
# Cookbook Name:: licode_cookbook
# Recipe:: default
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

root_dir = node[:licode_cookbook][:install_dir]
build_dir = "#{root_dir}/build"
lib_dir = "#{build_dir}/libdeps"
prefix_dir = "#{lib_dir}/build"

agu = execute "apt-get-update" do
  command "apt-get update -qq -y"
  returns [0,100]
  action :nothing
end

## First we need to add back in the Ubuntu default repositories
execute "copy-sources-list" do
  command "cp /etc/apt/sources.list.ORIG /etc/apt/sources.list"
  action :run
  only_if do FileTest.file?("/etc/apt/sources.list.ORIG") end
end

apt_repository "node.js" do
  uri "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
  distribution "precise"
  components ["main"]
  action :add
end

agu.run_action(:run)

## Licode build dependencies
package "python-software-properties"
package "software-properties-common"
#package "gcc"
package "g++"
package "make"
package "cmake"
package "libnice10"
package "libnice-dev"
#package "libglib2.0-dev"
#package "pkg-config"
package "libboost-regex-dev"
package "libboost-thread-dev"
package "libboost-system-dev"
package "liblog4cxx10-dev"
package "rabbitmq-server"
package "mongodb"
#package "openjdk-6-jre"
#package "curl"

package "yasm"
package "libvpx."
package "libx264."

package "nodejs" do
  options "--force-yes"
end

execute "npm-node-gyp" do
  command "npm install -g node-gyp@0.12.2"
  action :run
end

execute "npm-forever" do
  command "npm install -g forever@0.10.11"
  action :run
end

rightscale_marker :end
