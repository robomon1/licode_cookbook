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
  cwd "/var/lib/licode/scripts"
  code <<-EOH
    ./installErizo.sh
    EOH
  
end

rightscale_marker :end
