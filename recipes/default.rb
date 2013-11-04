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
package "yasm"
package "libvpx."
package "libx264."

apt_repository "node.js" do
  uri "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
  distribution "precise"
  components ["main"]
  action :add
  notifies :run, "execute[apt-get-update]", :immediately
end

package "nodejs" do
  options "--force-yes"
end

execute "npm-node-gyp" do
  command "npm install -g node-gyp"
  action :run
end

## Checkout the licode code first to get directories for building the rest 
git node[:licode_cookbook][:install_dir] do
  repository node[:licode_cookbook][:uri]
  reference "master"
  action :sync
end

## Install openssl for building erizo
bash "install-openssl" do
  cwd root_dir
  code <<-EOH
    mkdir -p #{lib_dir} 
    cd #{lib_dir}
    curl -O http://www.openssl.org/source/openssl-1.0.1e.tar.gz
    tar -zxvf openssl-1.0.1e.tar.gz
    cd openssl-1.0.1e
    ./config --prefix=#{prefix_dir} -fPIC
    make -s V=0
    make install
    EOH
end

## Install libnice for building erizo
bash "install-libnice" do
  cwd root_dir
  code <<-EOH
    mkdir -p #{lib_dir} 
    cd #{lib_dir}
    curl -O http://nice.freedesktop.org/releases/libnice-0.1.4.tar.gz
    tar -zxvf libnice-0.1.4.tar.gz
    cd libnice-0.1.4
    ./configure --prefix=#{prefix_dir}
    make -s V=0
    make install
    EOH
end

## Install mediadeps
bash "install-mediadeps" do
  cwd root_dir
  code <<-EOH
    mkdir -p #{lib_dir} 
    cd #{lib_dir}
    curl -O https://www.libav.org/releases/libav-9.9.tar.gz
    tar -zxvf libav-9.9.tar.gz
    cd libav-9.9
    ./configure --prefix=#{prefix_dir} --enable-shared --enable-gpl --enable-libvpx --enable-libx264
    make -s V=0
    make install
    EOH
end

## Install mediadeps_nogpl
bash "install-mediadeps_nogpl" do
  cwd root_dir
  code <<-EOH
    mkdir -p #{lib_dir} 
    cd #{lib_dir}
    curl -O https://www.libav.org/releases/libav-9.9.tar.gz
    tar -zxvf libav-9.9.tar.gz
    cd libav-9.9
    ./configure --prefix=#{prefix_dir} --enable-shared --enable-libvpx
    make -s V=0
    make install
    EOH
end

## Install libsrtp
bash "install-libsrtp" do
  cwd root_dir
  code <<-EOH
    mkdir -p #{root_dir}/third_party/srtp 
    cd #{root_dir}/third_party/srtp
    CFLAGS="-fPIC" ./configure --prefix=$PREFIX_DIR
    make -s V=0
    make uninstall
    make install
    cd $CURRENT_DIR
    EOH
end

rightscale_marker :end
