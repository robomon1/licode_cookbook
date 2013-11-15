#
# Cookbook Name:: licode_cookbook
# Recipe:: default
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

package "stunnel4"

# Save the cert
template "/etc/stunnel/well-fx.net.crt" do
  source "stunnel.crt.erb"
  cookbook "licode_cookbook"
  owner owner
  group group
  mode "0400"
  variables(
    :stunnel_certificate => node[:licode_cookbook][:stunnel_certificate]
  )
end

# Save the key
template "/etc/stunnel/star_well-fx_net.key" do
  source "stunnel.crt.erb"
  cookbook "licode_cookbook"
  owner owner
  group group
  mode "0400"
  variables(
    :stunnel_certificate => node[:licode_cookbook][:stunnel_key]
  )
end

# Save the CA cert
template "/etc/stunnel/gd_bundle.crt" do
  source "stunnel.crt.erb"
  cookbook "licode_cookbook"
  owner owner
  group group
  mode "0400"
  variables(
    :stunnel_certificate => node[:licode_cookbook][:stunnel_ca]
  )
end

# Writing stunnel configuration file
template "/etc/stunnel/stunnel.conf" do
  source "stunnel.conf.erb"
  cookbook "licode_cookbook"
  owner "root"
  group "root"
  mode "0644"
#  variables(
#    :client => params[:client],
#    :chroot => value_for_platform(
#      ["ubuntu"] => {"default" => "/var/lib/stunnel4/"},
#      ["centos", "redhat"] => {"default" => "/var/run/stunnel/"}
#    ),
#    :owner => owner,
#    :group => group,
#    :pid => value_for_platform(
#      ["ubuntu"] => {"default" => "/stunnel4.pid"},
#      ["centos", "redhat"] => {"default" => "/stunnel.pid"}
#    ),
#    :accept => params[:accept],
#    :connect => params[:connect],
#    :platform_version => node[:platform_version]
#  )
end

rightscale_marker :end
