#
# Cookbook Name:: peopletools
# Recipe:: system
#
# Copyright 2016 University of Derby
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# sysctl parameters
default['sysctl']['params']['kernel']['core_uses_pid'] = 1
default['sysctl']['params']['kernel']['msgmnb'] = 65_538
default['sysctl']['params']['kernel']['msgmni'] = 1024
default['sysctl']['params']['kernel']['msgmax'] = 65_536
default['sysctl']['params']['kernel']['shmmax'] = 68_719_476_736
default['sysctl']['params']['kernel']['shmall'] = 4_294_967_296
default['sysctl']['params']['kernel']['shmmni'] = 4096
default['sysctl']['params']['net']['ipv4']['ip_local_port_range'] = '10000 65500'
default['sysctl']['params']['net']['ipv4']['tcp_keepalive_time'] = 90
default['sysctl']['params']['net']['ipv4']['tcp_timestamps'] = 1
default['sysctl']['params']['net']['ipv4']['tcp_window_scaling'] = 1
include_recipe 'sysctl::apply'

# groups
[node['peopletools']['group']['psft_runtime']['name'],
 node['peopletools']['group']['psft_app_install']['name'],
 node['peopletools']['group']['oracle_install']['name'],
 node['peopletools']['group']['oracle_runtime']['name']
].each do |g|
  group g do
    append true
    action :create
  end
end

# users
{ node['peopletools']['user']['psft_install']['name'] => node['peopletools']['group']['oracle_install']['name'],
  node['peopletools']['user']['psft_runtime']['name'] => node['peopletools']['group']['oracle_install']['name'],
  node['peopletools']['user']['psft_app_install']['name'] => node['peopletools']['group']['psft_app_install']['name'],
  node['peopletools']['user']['oracle']['name'] => node['peopletools']['group']['oracle_install']['name']
}.each do |n, g|
  user n do
    gid g
    home ::File.join(node['peopletools']['user']['home_dir'], n)
    shell node['peopletools']['user']['shell']
    supports manage_home: true
  end
end

# psft_runtime group membership
group node['peopletools']['group']['psft_runtime']['name'] do
  append true
  members [node['peopletools']['user']['psft_install']['name'],
           node['peopletools']['user']['psft_runtime']['name'],
           node['peopletools']['user']['psft_app_install']['name']
          ]
  action :create
end

# oracle_runtime group membership
group node['peopletools']['group']['oracle_runtime']['name'] do
  append true
  members node['peopletools']['user']['oracle']['name']
  action :create
end

# limits
[node['peopletools']['group']['psft_runtime']['name'],
 node['peopletools']['group']['psft_app_install']['name']
].each do |g|
  limits_config g do
    limits_array = []
    node['peopletools']['limits']['group'].each do |t, a|
      a.each do |i, v|
        limits_array.push(domain: g, type: t, item: i, value: v)
      end
    end
    limits limits_array
    only_if { node['peopletools']['limits']['group'].respond_to?('each') }
  end
end

# pt directory
directory ::File.join(node['peopletools']['psft']['path'], node['peopletools']['pt']['dir']) do
  owner node['peopletools']['user']['psft_install']['name']
  group node['peopletools']['group']['oracle_install']['name']
  mode 0755
  recursive true
end
