#!/bin/bash

#set -e

RSA_PATH="/opt/rsa/rsa_private_key.pem"
ORG_RSA_PATH="/opt/rsa/TEST-validator.pem"

USER_NAME="chefsrv"
PASSWORD="ChefAdmin123"

FIRST_NAME="Sergii"
LAST_NAME="Dementiev"
ORG_NAME="TEST"
ORG_SHORT_NAME="tmpchef"
EMAIL="chefsrv@srv.local"

if [ ! -d directory ]; then
  sudo mkdir /opt/rsa
fi

sudo yum -y install ntp
sudo systemctl enable ntpd
sudo systemctl start ntpd

sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

echo "Checking qpid"
if [ "`rpm -qa | grep qpid`" ]
then
  sudo systemctl stop qpidd
  sudo chkconfig --del qpidd
fi

echo "Setting enforce Permissive"
if [ "`setenforce`" != 'Permissive' ]
then
  sudo setenforce Permissive
fi

sudo rpm -Uvh /opt/install/chef-server-core-12.19.31-1.el7.x86_64.rpm

sudo chef-server-ctl reconfigure

sudo chef-server-ctl user-create $USER_NAME $FIRST_NAME $LAST_NAME $EMAIL $PASSWORD --filename $RSA_PATH

sudo chef-server-ctl org-create $ORG_SHORT_NAME $ORG_NAME --association_user $USER_NAME --filename $ORG_RSA_PATH

sudo chef-server-ctl install chef-manage
sudo chef-server-ctl reconfigure --chef-license=accept
sudo chef-manage-ctl reconfigure --accept-license

# sudo chef-server-ctl install opscode-push-jobs-server
# sudo opscode-push-jobs-server-ctl reconfigure
# sudo chef-server-ctl install opscode-reporting
#
# sudo chef-server-ctl reconfigure
# sudo opscode-reporting-ctl reconfigure --accept-license
