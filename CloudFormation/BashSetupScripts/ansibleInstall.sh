#!/bin/bash
dockerTestIp="34.194.241.77"
dockerProdIp="54.197.44.45"
serverDBIp="3.212.208.35"
jenkinsServerIp="44.212.190.21"
ansibleServerIp="34.226.35.32"

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
#install docker
sudo yum install docker -y
#add ansibleadmin to docker group
sudo usermod -aG docker ansibleadmin

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
echo "[jenkinsserver]" >> /etc/ansible/hosts
echo $jenkinsServerIp >> /etc/ansible/hosts


#Move ansible folder to /home/ansibleadmin
cp -r ~/Devops_A3/Ansible /home/ansibleadmin

#Move Dockerfiles to /home/ansibleadmin
cp -r ~/Devops_A3/DockerFiles /home/ansibleadmin

#Move UnitTest to /home/ansibleadmin
cp -r ~/Devops_A3/UnitTest /home/ansibleadmin

#wait other instance to be done
sleep 60

#copy ssh key to all hosts
su - ansibleadmin
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N "" << EOF
echo "123" | sshpass ssh-copy-id $ansibleServerIp
echo "123" | sshpass ssh-copy-id $jenkinsServerIp
echo "123" | sshpass ssh-copy-id $dockerProdIp
echo "123" | sshpass ssh-copy-id $dockerTestIp
echo "123" | sshpass ssh-copy-id $serverDBIp
EOF


# #change hostname to ansible-server in /etc/hostname
# echo "ansible-server" > /etc/hostname

# #reboot
# reboot
