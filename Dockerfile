#DockerFile for Ansible

FROM ubuntu:latest
MAINTAINER Harsha
RUN apt-get update
RUN apt-get install wget vim -y
RUN apt-get install python -y
RUN apt-get install software-properties-common python-pip -y
RUN pip install --upgrade pip
RUN apt-get install sshpass -y
RUN apt-get install openssh-server -y
RUN apt-get install apt-transport-https ca-certificates -y
RUN apt-get install python-dev libffi-dev libssl-dev -y 
RUN pip install setuptools
RUN pip install pyopenssl ndg-httpsclient pyasn1
# Using pip to ansible to get latest ansible release.
RUN pip install ansible                              
      
# Creating ansible configuration directory.
RUN mkdir -p /etc/ansible                                    
RUN echo "[local]\n127.0.0.1" | tee -a /etc/ansible/hosts
COPY ansible.cfg /etc/ansible/ansible.cfg                     

# Creating a local  ansible  workspace.
RUN mkdir ansible	                                       
WORKDIR /root/ansible					      
RUN mkdir files playbooks templates group_vars
# Ansible log path.                
RUN mkdir -p /var/log/ansible				     

WORKDIR /root
RUN echo ANSIBLE_CONFIG= /etc/ansible/ansible.cfg >> ~/.profile  

RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""

RUN sed -i "12i inventory = /etc/ansible/hosts\nlog_path = /var/log/ansible/ansible.log\nprivate_key_file = ~/.ssh/id_rsa" /etc/ansible/ansible.cfg

RUN sed -i '11i host_key_checking = False'  /etc/ansible/ansible.cfg

RUN echo "docker\ndocker" | passwd root

RUN sed -i '/PermitRootLogin prohibit-password/d' /etc/ssh/sshd_config

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

COPY ssh_start.sh /root/ssh_start.sh                         

RUN chmod +x /root/ssh_start.sh

ENTRYPOINT ["/root/ssh_start.sh"]
