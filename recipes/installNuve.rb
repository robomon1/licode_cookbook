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

rightscale_marker :end
