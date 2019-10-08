1) Create cookbook which will install and configure tomcat application server as backend, nginx server as frontend and data base mysql.
- All configurations should be in resources.
- In addition please use lazy parameters (at least 3 parameters should be lazy)
- Create at least 3 users (OS users) with different privileges.
- Secure your nginx and tomcat with SSL certificates.
- Please store SSL certificate content in chef Vault or Chef Encrypted Databags.

2) Write unit test for you cookbook. Test your cookbook with unit tests
3) Run lint tools against your cookbook (cookstyle, foodcritic). Correct all smells.


- add FQDN name of Chef server to your nodes
- add FQDN of a Chef server to your local machine
- go to Administration panel and download starter kit
- knife bootstrap IP -N name -x name -i vagrant-machine-private-key --sudo
- chef generate cookbook <name> //create cookbook
- knife upload <cookbook name> //upload cookbook to chef server
- knife node run_list add vm-db 'springappsetup::backend' //add cookbook to runlist to a specific node
- knife ssh 'name:vm-db' 'sudo chef-client' -x vagrant -i .chef/vm_db_private_key //run chef client on a node


To remove the offending key from your ~/.ssh/config file use ssh-keygen -R
ssh-keygen -R 192.0.2.0
Or bootstrap with the --no-host-key-verify option (not recommended since less secure)
knife bootstrap 192.0.2.0 --no-host-key-verify
