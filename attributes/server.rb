#
# Cookbook Name:: jenkins
# Attributes:: server
#
# Author:: Doug MacEachern <dougm@vmware.com>
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Seth Chisamore <schisamo@opscode.com>
#
# Copyright 2010, VMware, Inc.
# Copyright 2012, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['jenkins']['server']['home'] = '/var/lib/jenkins'
default['jenkins']['server']['log_dir'] = '/var/log/jenkins'

default['jenkins']['server']['user'] = 'jenkins'
default['jenkins']['server']['dir_permissions'] = 00755
default['jenkins']['server']['ssh_dir_permissions'] = 00700
case node['platform_family']
when 'debian'
  default['jenkins']['server']['install_method'] = 'package'
  default['jenkins']['server']['config_path'] = '/etc/default/jenkins'
  default['jenkins']['server']['config_template'] = 'default.erb'
  default['jenkins']['server']['log_dir_permissions'] = 00755
  default['jenkins']['server']['home_dir_group'] = 'adm'
  default['jenkins']['server']['plugins_dir_group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['log_dir_group'] = 'adm'
  default['jenkins']['server']['ssh_dir_group'] = 'nogroup'
when 'rhel'
  default['jenkins']['server']['install_method'] = 'package'
  default['jenkins']['server']['group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['config_path'] = '/etc/sysconfig/jenkins'
  default['jenkins']['server']['config_template'] = 'sysconfig.erb'
  default['jenkins']['server']['log_dir_permissions'] = 00750
  default['jenkins']['server']['home_dir_group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['plugins_dir_group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['log_dir_group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['ssh_dir_group'] = node['jenkins']['server']['user']
else
  default['jenkins']['server']['install_method'] = 'war'
  default['jenkins']['server']['group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['log_dir_permissions'] = 00755
  default['jenkins']['server']['home_dir_group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['plugins_dir_group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['log_dir_group'] = node['jenkins']['server']['user']
  default['jenkins']['server']['ssh_dir_group'] = node['jenkins']['server']['user']
end

default['jenkins']['server']['version'] = nil
default['jenkins']['server']['war_checksum'] = nil

default['jenkins']['server']['port'] = 8080
default['jenkins']['server']['host'] = node['fqdn']
default['jenkins']['server']['url']  = "http://#{node['jenkins']['server']['host']}:#{node['jenkins']['server']['port']}"

default['jenkins']['server']['plugins'] = []
default['jenkins']['server']['jvm_options'] = nil
default['jenkins']['server']['pubkey'] = nil
