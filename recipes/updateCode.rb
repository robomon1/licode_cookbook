#
# Cookbook Name:: licode_cookbook
# Recipe:: installErizo
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

log "  Downloading project repo"
# Calling "repo" LWRP to download remote project repository
# See cookbooks/repo/resources/default.rb for the "repo" resource.
repo "default" do
  destination node[:licode_cookbook][:install_dir]
  action node[:repo][:default][:perform_action].to_sym
  repository node[:repo][:default][:repository]
  persist false
end

rightscale_marker :end
