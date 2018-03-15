# docker-ansible
Dockerfile for building image with Ansible - Using Ansible in a Docker Container

**Pre-requisites**: Linux machine with docker running.

Installing docker in Ubuntu/Debain

  > **# sudo apt-get update**

  > **# sudo apt-get install docker.io**

# Usage:
 
Build the Docker image using the Dockerfile.

 > **# docker build -t <"image_name"> .**

This will build the image using ubuntu with ansible.

Running the built image as container and testing.
 
 > **# docker run -it <image_id> /bin/bash**

Inside the conatiner you will be able run ansible commands. Verify it by using simple Ansible ad-hoc command.

 > **# ansible local -m ping -u root -k**                    # Default password for root is "docker".

Change the password of the root user as required in Dockerfile or after entering into the conatiner.
To add hosts/hostgroups edit /etc/ansible/ansible.cfg

If the target host is AWS instance use --private-key <.pem> with ansible command.

**Reference:** https://fabianlee.org/2017/06/04/ansible-installing-ansible-on-ubuntu-14-04/
