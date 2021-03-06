#
# Cookbook Name:: licode_cookbook
# Recipe:: installErizo
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

bash "install_nuve" do
  cwd "#{node[:licode_cookbook][:install_dir]}/nuve"
  code <<-EOH
    ./installNuve.sh
    EOH

end

# Install the upstart script
template "/etc/init/nuve.conf" do
  source "nuve_conf.erb"
  cookbook "licode_cookbook"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :install_dir => node[:licode_cookbook][:install_dir]
  )
end

rightscale_marker :end
