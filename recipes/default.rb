#
# Cookbook Name:: licode_cookbook
# Recipe:: default
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get-update" do
  command "apt-get update -qq -y"
  returns [0,100]
  action :nothing
end

## First we need to add back in the Ubuntu default repositories
execute "copy-sources-list" do
  command "cp /etc/apt/sources.list.ORIG /etc/apt/sources.list"
  action :run
  only_if do FileTest.file?("/etc/apt/sources.list.ORIG") end
  notifies :run, "execute[apt-get-update]", :immediately
end

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

apt_repository "node.js" do
  uri "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
  distribution "precise"
  components ["main"]
  action :add
  notifies :run, "execute[apt-get-update]", :immediately
end

package "nodejs"