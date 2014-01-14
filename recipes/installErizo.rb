#
# Cookbook Name:: licode_cookbook
# Recipe:: installErizo
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

bash "install_erizo" do
  cwd "#{node[:licode_cookbook][:install_dir]}/scripts"
  code <<-EOH
    ./installErizo.sh
    EOH
end

rightscale_marker :end
