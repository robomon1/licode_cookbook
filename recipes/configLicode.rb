#
# Cookbook Name:: licode_cookbook
# Recipe:: default
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

directory "/etc/certs" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

# Save the licode_config.js file
template "#{node[:licode_cookbook][:install_dir]}/licode_config.js" do
  source "licode_config_js.erb"
  cookbook "licode_cookbook"
  owner owner
  group group
  mode "0644"
  variables(
    :rabbitmq_host => node[:licode_cookbook][:rabbitmq_host],
    :rabbitmq_port => node[:licode_cookbook][:rabbitmq_port],
    :mongodb_url => node[:licode_cookbook][:mongodb_url],
    :erizo_controller => node[:licode_cookbook][:erizo_controller],
    :erizo_controller_port => node[:licode_cookbook][:erizo_controller_port],
    :erizo_controller_ssl => node[:licode_cookbook][:erizo_controller_ssl],
    :ssl_crt => node[:licode_cookbook][:ssl_crt],
    :ssl_key => node[:licode_cookbook][:ssl_key],
    :ssl_ca => node[:licode_cookbook][:ssl_ca],
    :turnserver_url => node[:licode_cookbook][:turnserver_url],
    :turnserver_username => node[:licode_cookbook][:turnserver_username],
    :turnserver_password => node[:licode_cookbook][:turnserver_password],
    :stunserver_host => node[:licode_cookbook][:stunserver_host],
    :stunserver_port => node[:licode_cookbook][:stunserver_port],
    :aws_access_key => node[:licode_cookbook][:aws_access_key],
    :aws_secret_key => node[:licode_cookbook][:aws_secret_key]
  )
end

rightscale_marker :end
