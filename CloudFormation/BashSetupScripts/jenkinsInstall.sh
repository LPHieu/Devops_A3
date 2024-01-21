#!/bin/bash
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
yum install git -y

#in /etc/ssh/sshd_config, change "PasswordAuthentication no" to "PasswordAuthentication yes" to turn on password authentication in ssh
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

service sshd restart

useradd ansibleadmin
#set password for ansibleadmin as 123
echo "123" | passwd --stdin ansibleadmin

#start jenkins
service jenkins start
#wait for jenkins to start

#wait for jenkins to start
sleep 30

JENKINS_ADDRESS=http://localhost:8080
#install jenkins cli
wget $JENKINS_ADDRESS/jnlpJars/jenkins-cli.jar

#get generated password
PASSWORD=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
#login jenkins 
java -jar jenkins-cli.jar -s $JENKINS_ADDRESS -auth admin:$PASSWORD install-plugin publish-over-ssh github workflow-aggregator mailer
cat /root/Devops_A3/Jenkins/job.xml | java -jar jenkins-cli.jar -s $JENKINS_ADDRESS -auth admin:$PASSWORD create-job Assessment3Job

service jenkins restart

# #change hostname to jenkins-server in /etc/hostname
# echo "jenkins-server" > /etc/hostname

# #reboot
# reboot
