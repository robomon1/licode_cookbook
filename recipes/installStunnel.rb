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
    :stunnel_certificate => node[:licode_cookbook][:stunnel_cert]
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
template "/etc/default/stunnel4" do
  source "stunnel.default.erb"
  cookbook "licode_cookbook"
  owner "root"
  group "root"
  mode "0644"
end

# Writing stunnel configuration file
template "/etc/stunnel/stunnel.conf" do
  source "stunnel.conf.erb"
  cookbook "licode_cookbook"
  owner "root"
  group "root"
  mode "0644"
end

# Enabling stunnel to start on system boot and restarting to apply new settings
service value_for_platform(
  ["ubuntu"] => {"default" => "stunnel4"},
  ["centos", "redhat"] => {"default" => "stunnel"}
) do
  supports :reload => true, :restart => true, :start => true, :stop => true
  action [:enable, :restart]
end

# Lets update the iptables to allow for dev gwt debug mode
execute "insert port reroute firewall rule" do
  user "root"
  group "root"
  #command "/sbin/iptables -I OUTPUT -p tcp -d 127.0.0.1 --dport 85 -j DROP"
  command "/sbin/iptables -t nat -I PREROUTING -p tcp --dport 8888 -j REDIRECT --to-ports 8080 && /sbin/iptables -t nat -I PREROUTING -p udp --dport 8888 -j REDIRECT --to-ports 8080"
  action :run
end

rightscale_marker :end
