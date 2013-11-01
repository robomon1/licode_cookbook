#
# Cookbook Name:: licode_cookbook
# Recipe:: installErizo
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

script "installErizo.sh" do
  cwd "/var/lib/licode/scripts"  
end

rightscale_marker :end
