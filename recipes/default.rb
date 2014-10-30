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

## apt dependencies
package "python-software-properties"
package "software-properties-common"
package "cmake"
package "curl"
package "git"
package "gcc"
package "g++"
package "libboost-regex-dev"
package "libboost-thread-dev"
package "libboost-system-dev"
package "libboost-test-dev"
package "libglib2.0-dev"
package "liblog4cxx10-dev"
package "libssl-dev"
package "make"
package "mongodb"
package "nodejs" do
  options "--force-yes"
end
package "openjdk-6-jre"
package "pkg-config"
package "rabbitmq-server"

package "libvpx."
package "libx264."
package "yasm"


## Downlaod and install openssl
execute "get-openssl" do
  command "curl -O http://www.openssl.org/source/openssl-1.0.1g.tar.gz"
  cwd "#{lib_dir}"
  creates "#{lib_dir}/openssl-1.0.1g.tar.gz"
  action :run
end

execute "untar-openssl" do
  command "tar xzvf #{lib_dir}/openssl-1.0.1g.tar.gz"
  cwd "#{lib_dir}"
  creates "#{lib_dir}/openssl-1.0.1g"
  action :run
end

execute "config-openssl" do
  command "./config --prefix=#{prefix_dir} -fPIC"
  cwd "#{lib_dir}/openssl-1.0.1g"
  action :run
end

execute "make-openssl" do
  command "make -s V=0"
  cwd "#{lib_dir}/openssl-1.0.1g"
  action :run
end

execute "install-openssl" do
  command "make install"
  cwd "#{lib_dir}/openssl-1.0.1g"
  action :run
end

## Downlaod and install libnice
execute "get-libnice" do
  command "curl -O http://nice.freedesktop.org/releases/libnice-0.1.4.tar.gz"
  cwd "#{lib_dir}"
  creates "#{lib_dir}/libnice-0.1.4.tar.gz"
  action :run
end

execute "untar-libnice" do
  command "tar xzvf #{lib_dir}/libnice-0.1.4.tar.gz"
  cwd "#{lib_dir}"
  creates "#{lib_dir}/libnice-0.1.4"
  action :run
end

execute "patch-libnice" do
#  command "patch -R ./agent/conncheck.c < #{root_dir}/scripts/libnice-014.patch0"
  command "patch -t ./agent/conncheck.c < #{root_dir}/scripts/libnice-014.patch0"
  cwd "#{lib_dir}/libnice-0.1.4"
  action :run
end

execute "config-libnice" do
  command "./configure --prefix=#{prefix_dir}"
  cwd "#{lib_dir}/libnice-0.1.4"
  action :run
end

execute "make-libnice" do
  command "make -s V=0"
  cwd "#{lib_dir}/libnice-0.1.4"
  action :run
end

execute "install-libnice" do
  command "make install"
  cwd "#{lib_dir}/libnice-1.0.1g"
  action :run
end

## Install libsrtp
execute "config-libsrtp" do
  command "CFLAGS='-fPIC' ./configure --prefix=#{prefix_dir}"
  cwd "#{root_dir}/third_party/srtp"
  action :run
end

execute "make-libsrtp" do
  command "make -s V=0"
  cwd "#{root_dir}/third_party/srtp"
  action :run
end

execute "uninstall-libsrtp" do
  command "make uninstall"
  cwd "#{root_dir}/third_party/srtp"
  action :run
end

execute "install-libsrtp" do
  command "make install"
  cwd "#{root_dir}/third_party/srtp"
  action :run
end

## Downlaod and install opus
execute "get-opus" do
  command "curl -O http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz"
  cwd "#{lib_dir}"
  creates "#{lib_dir}/opus-1.1.tar.gz"
  action :run
end

execute "untar-opus" do
  command "tar xzvf #{lib_dir}/opus-1.1.tar.gz"
  cwd "#{lib_dir}"
  creates "#{lib_dir}/opus-1.1"
  action :run
end

execute "config-opus" do
  command "./configure --prefix=#{prefix_dir}"
  cwd "#{lib_dir}/opus-1.1"
  action :run
end

execute "make-opus" do
  command "make -s V=0"
  cwd "#{lib_dir}/opus-1.1"
  action :run
end

execute "install-opus" do
  command "make install"
  cwd "#{lib_dir}/opus-1.1"
  action :run
end

## Downlaod and install mediadeps
execute "get-mediadeps" do
  command "curl -O https://www.libav.org/releases/libav-9.13.tar.gz"
  cwd "#{lib_dir}"
  creates "#{lib_dir}/libav-9.13.tar.gz"
  action :run
end

execute "untar-mediadeps" do
  command "tar xzvf #{lib_dir}/libav-9.13.tar.gz"
  cwd "#{lib_dir}"
  creates "#{lib_dir}/libav-9.13"
  action :run
end

execute "config-mediadeps" do
  command "PKG_CONFIG_PATH=#{prefix_dir}/lib/pkgconfig ./configure --prefix=#{prefix_dir} --enable-shared --enable-gpl --enable-libvpx --enable-libx264 --enable-libopus"
  cwd "#{lib_dir}/libav-9.13"
  action :run
end

execute "make-mediadeps" do
  command "make -s V=0"
  cwd "#{lib_dir}/mediadeps-1.1"
  action :run
end

execute "install-mediadeps" do
  command "make install"
  cwd "#{lib_dir}/mediadeps-1.1"
  action :run
end

#sudo npm install -g node-gyp
#sudo chown -R `whoami` ~/.npm ~/tmp/
execute "npm-node-gyp" do
  command "npm install -g node-gyp"
  action :run
end

execute "npm-forever" do
  command "npm install -g forever"
  action :run
end

rightscale_marker :end
