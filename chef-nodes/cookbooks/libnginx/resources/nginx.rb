property :conf_path, String, required: true
property :template_source, String, required: true
property :template_owner, String, default: 'root'
property :template_group, String, default: 'root'
property :fmode, String, default: '0644'

epelrepo = '/home/vagrant/epel.rpm'

action :install do

  remote_file epelrepo do
    source 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
    owner 'vagrant'
    group 'vagrant'
    mode '0755'
  end

  package epelrepo do
    action :install
  end

  package 'nginx' do
    action :install
  end

  template new_resource.conf_path do
    source   new_resource.template_source
    owner    new_resource.template_owner
    group    new_resource.template_group
    mode     new_resource.fmode
    #notifies :reload, 'service[nginx]', :delayed
  end

  service 'nginx' do
    action [:enable, :start]
  end

end
# directory '/etc/ssl/nginx' do
#   owner  'root'
#   group  'root'
#   mode   '0755'
#   action :create
# end
#
# file '/etc/ssl/nginx/nginx-repo.key' do
#   owner   'root'
#   group   'root'
#   mode    '0644'
#   content node.attribute['nginx']['nginx_repo_key']
# end
#
# file '/etc/ssl/nginx/nginx-repo.crt' do
#   owner   'root'
#   group   'root'
#   mode    '0644'
#   content node.attribute['nginx']['nginx_repo_crt']
# end
#
# directory node['nginx']['dir'] do
#   owner     'root'
#   group     node['root_group']
#   mode      '0755'
#   recursive true
# end
#
# directory node['nginx']['log_dir'] do
#   mode      node['nginx']['log_dir_perm']
#   owner     node['nginx']['user']
#   action    :create
#   recursive true
# end
#
# directory File.dirname(node['nginx']['pid']) do
#   owner     'root'
#   group     node['root_group']
#   mode      '0755'
#   recursive true
# end
#
# directory "#{node['nginx']['dir']}/conf.d" do
#   owner 'root'
#   group node['root_group']
#   mode  '0755'
# end
#
# service 'nginx' do
#   supports :status => true, :restart => true, :reload => true
#   action   :enable
# end
#
# template 'nginx.conf' do
#   path     "#{node['nginx']['dir']}/nginx.conf"
#   source   node['nginx']['conf_template']
#   cookbook node['nginx']['conf_cookbook']
#   owner    'root'
#   group    node['root_group']
#   mode     '0644'
#   notifies :reload, 'service[nginx]', :delayed
# end
#
# if node['nginx']['default_site_enabled'] == 'true'
#   template "#{node['nginx']['dir']}/conf.d/default.conf" do
#     source   'default-site.erb'
#     owner    'root'
#     group    node['root_group']
#     mode     '0644'
#     notifies :reload, 'service[nginx]', :delayed
#   end
# else
#   file "#{node['nginx']['dir']}/conf.d/default.conf" do
#     action :delete
#   end
# end
#
# if node['nginx']['plus_status_enable'] == 'true'
#   template 'nginx_plus_status' do
#     path   "#{node['nginx']['dir']}/conf.d/nginx_plus_status.conf"
#     source 'nginx_plus_status.erb'
#     owner  'root'
#     group  node['root_group']
#     mode   '0644'
#     notifies :reload, 'service[nginx]', :delayed
#   end
# end
