# execute 'update-upgrade' do
#   command 'sudo yum update -y'
#   action :run
# end

libnginx_nginx 'nginx' do
  action :install
end
