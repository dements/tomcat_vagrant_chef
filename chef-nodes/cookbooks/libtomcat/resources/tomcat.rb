tomcat_users = '/opt/tomcat/conf/tomcat-users.xml'
tomcat_service = '/etc/systemd/system/tomcat.service'
tomcat_arch = '/home/vagrant/tomcat.tar.gz'
tomcat_dir = '/opt/tomcat'
tomcat_manager = '/opt/tomcat/webapps/manager/META-INF/context.xml'
epelrepo = '/home/vagrant/epel.rpm'
epelrepo_source = 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
tomcat_source = 'http://apache.cp.if.ua/tomcat/tomcat-8/v8.5.46/bin/apache-tomcat-8.5.46.tar.gz'
java_pkg = 'java-1.8.0-openjdk.x86_64'
maven_pkg = 'maven'

action :install do

  remote_file epelrepo do
    source epelrepo_source
    owner 'vagrant'
    group 'vagrant'
    mode '0755'
  end

  package epelrepo do
    action :install
  end

  package java_pkg do
    action :install
    flush_cache( {:after => true} )
  end

  package maven_pkg do
    action :install
    flush_cache( {:after => true} )
  end

  remote_file tomcat_arch do
    source tomcat_source
    owner 'vagrant'
    group 'vagrant'
    mode '0755'
  end

  group 'tomcat' do
    append true
  end

  user 'tomcat' do
    uid 1122
    gid 'tomcat'
    home '/opt/tomcat'
    shell '/bin/nologin'
    password 'tomcat123'
  end

  directory tomcat_dir do
    action :create
    owner 'tomcat'
    group 'tomcat'
    mode '0755'
    action :create
  end

  execute 'extract_tomcat' do
    command "sudo tar -zxvf #{tomcat_arch} -C /opt/tomcat --strip-components=1"
    cwd '/home/vagrant'
  end

  execute 'extract_tomcat' do
    command 'sudo chown tomcat:tomcat -R /opt/tomcat/'
    cwd '/home/vagrant'
  end

  template tomcat_service do
    source   'tomcat.service.erb'
    owner    'root'
    group    'root'
    mode     '0644'
  end

  file tomcat_users do
    action :delete
  end

  template tomcat_users do
    source   'tomcat-users.xml.erb'
    owner    'tomcat'
    group    'tomcat'
    mode     '0755'
  end

  file tomcat_manager do
    action :delete
  end

  template tomcat_manager do
    source   'context.xml.erb'
    owner    'tomcat'
    group    'tomcat'
    mode     '0755'
  end

  service 'tomcat.service' do
    action [:enable, :start]
  end

end
