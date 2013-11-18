#
# Cookbook Name:: licode_cookbook
#
# Copyright 2013, WellFX, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Licode install (root) dir
default[:licode_cookbook][:install_dir] = "/var/lib/licode"

# Licode erizo controller defaults to first public ip
default[:licode_cookbook][:erizo_controller] = node[:cloud][:public_ips][0] 
