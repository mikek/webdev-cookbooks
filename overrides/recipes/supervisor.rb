chef_gem 'chef-rewind'
require 'chef/rewind'


# Supervisor overrides
include_recipe 'supervisor'

sysv_supervisor_scripts =  [
  "/etc/init.d/supervisor",
  "/etc/default/supervisor"
]

sysv_supervisor_scripts.each do |f|
  file f do
    action :delete
  end

end

cookbook_file "/etc/init/supervisor.conf" do
  source "supervisor.conf"
  mode "0644"
  owner "root"
  group "root"
end

unwind "service[supervisor]"

service 'supervisor' do
  provider Chef::Provider::Service::Upstart
  supports [:restart, :status]
  action [:enable, :start]
end
