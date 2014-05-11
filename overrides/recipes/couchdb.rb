chef_gem 'chef-rewind'
require 'chef/rewind'


# CouchDB overrides
include_recipe 'couchdb::source'

sysv_couchdb_scripts =  [
  "/usr/local/etc/init.d/couchdb",
  "/usr/local/etc/default/couchdb",
  "/etc/init.d/couchdb"
]

sysv_couchdb_scripts.each do |f|
  file f do
    action :delete
  end
end

cookbook_file "/etc/security/limits.d/100-couchdb.conf" do
  source "couchdb_limits.conf"
  mode "0644"
  owner "root"
  group "root"
end

cookbook_file "/etc/init/couchdb.conf" do
  source "couchdb.conf"
  mode "0644"
  owner "root"
  group "root"
end

unwind "service[couchdb]"

service 'couchdb' do
  provider Chef::Provider::Service::Upstart
  supports [:restart, :status]
  action :enable
end


unwind "template[/usr/local/etc/couchdb/local.ini]"

template "/usr/local/etc/couchdb/local.d/chef_managed.ini" do
  source "couchdb_chef.ini.erb"
  owner "couchdb"
  group "couchdb"
  mode 0664
  variables(
    :config => node['couch_db']['config']
  )
  notifies :restart, 'service[couchdb]'
  cookbook_name 'basiclogger'
end
