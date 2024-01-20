#!/bin/bash
dockerTestIp="54.174.242.128"
dockerProdIp="54.144.197.26"
serverDBIp="44.218.193.34"
jenkinsServerIp="100.24.188.25"
ansibleServerIp="3.223.20.139"

useradd ansibleadmin
#set password for ansibleadmin as 123
echo "123" | passwd --stdin ansibleadmin

#in /etc/sudoers, add "ansibleadmin ALL=(ALL) NOPASSWD: ALL" so that ansibleadmin can run sudo command without password
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#in /etc/ssh/sshd_config, change "PasswordAuthentication no" to "PasswordAuthentication yes" to turn on password authentication in ssh
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

#restart sshd
service sshd reload

#install ansible
amazon-linux-extras install ansible2 -y
#install ansible docker module
ansible-galaxy collection install community.docker
#install docker
sudo yum install docker -y
#add ansibleadmin to docker group
sudo usermod -aG docker ansibleadmin
#login docker for pushing image
docker login --username ttrung --password tranquoctrung

#Move playbooks and dockerfiles to /home/ansibleadmin

#Setup ansible hosts file
echo "[ansibleserver]" > /etc/ansible/hosts
echo $ansibleServerIp >> /etc/ansible/hosts
echo "[dockerservertest]" >> /etc/ansible/hosts
echo $dockerTestIp >> /etc/ansible/hosts
echo "[dockerserverprod]" >> /etc/ansible/hosts
echo $dockerProdIp >> /etc/ansible/hosts
echo "[mariadb]" >> /etc/ansible/hosts
echo $serverDBIp >> /etc/ansible/hosts


#Move ansible folder to /home/ansibleadmin
cp -r ~/Devops_A3/Ansible /home/ansibleadmin

#Move Dockerfiles to /home/ansibleadmin
cp -r ~/Devops_A3/DockerFiles /home/ansibleadmin

#Move UnitTest to /home/ansibleadmin
cp -r ~/Devops_A3/UnitTest /home/ansibleadmin

#wait other instance to be done
sleep 60

#copy ssh key to all hosts
su - ansibleadmin << EOF
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
echo "123" | sshpass ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $ansibleServerIp
echo "123" | sshpass ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null@ $jenkinsServerIp
echo "123" | sshpass ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null@ $dockerProdIp
echo "123" | sshpass ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null@ $dockerTestIp
echo "123" | sshpass ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null@ $serverDBIp
ansible all -m ping --ssh-common-args='-o StrictHostKeyChecking=no'
EOF


# #change hostname to ansible-server in /etc/hostname
# echo "ansible-server" > /etc/hostname

# #reboot
# reboot
