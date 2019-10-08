#wpdbsetup = data_bag_item('wp-config-values', "wp_db_setup")

# execute 'update-upgrade' do
#   command 'sudo yum update -y'
#   action :run
# end

libtomcat_tomcat 'tomcat' do
  action :install
end


# wpsetup_wordpress 'wp' do
#   action :install
# end

# template '/var/www/html/wp-config.php' do
#   source 'wp-config.php.erb'
#   owner 'apache'
#   group 'apache'
#   variables(
#     db_name: wpdbsetup['name'],
#     db_user: wpdbsetup['user'],
#     db_password: wpdbsetup['password'],
#     db_host: wpdbsetup['host'],
#     db_charset: wpdbsetup['charset'],
#   )
#   action :create
# end
#
# remote_file '/home/vagrant/latest.tar.gz' do
#   source 'http://wordpress.org/latest.tar.gz'
#   owner 'vagrant'
#   group 'vagrant'
#   mode '0755'
# end
#
# execute 'unpack wp' do
#   command 'sudo tar --strip 1 -xzvf /home/vagrant/latest.tar.gz -C /var/www/html/ wordpress'
# end
#
# libapache2_apache2 'reload_apache' do
#   action :reload
# end
