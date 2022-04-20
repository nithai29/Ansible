# Ansible

## Install Ansible

Before you install Ansible, review the requirements for a control node.

### Prerequisites

- Python
- SSH

### Installing Ansible on RHEL, CentOS, or Fedora

On Fedora:

```bash
sudo dnf install ansible
```

On RHEL:

```bash
sudo yum install ansible
```

On CentOS:

```bash
sudo yum install epel-release
sudo yum install ansible
```

On Amazon Linux:

```bash
sudo amazon-linux-extras install ansible2
```

On Ubuntu:

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

### Verifying Ansible

```bash
ansible --version
ansible 2.9.27
  config file = /etc/ansible/ansible.cfg
```

Ansible is successfully installed and verified.

## Initial automation using Ansible

Setup SSH between two AWS EC2 instances using Ansible

### Agenda

- Connect to Ansible master instance.
- Setup a new user "devops" on the Ansible master instance manually.
- Run the playbook to create a new user(devops) on all new instances.

Note: Ansible uses SSH to communicate between instances.

#### Situation

Login to each of the servers and create new user and setup ssh authorized_keys manually.

#### Tasks

Create an ansible playbook to setup the user.

#### Actions

Use the .pem file associated with the Ansible master instances to connect.

Setup a new user(devops) on Master instance.
Create a user devops

```bash
sudo -i
useradd -m -s /bin/bash devops
```

Set password

```bash
passwd devops
```

Add the user in sudoers.d file, this allow user to run any command using sudo without passing their password

```bash
echo -e ‘devops\tALL=(ALL)\tNOPASSWD:\tALL’ > /etc/sudoers.d/devops
```

Note: To encrypt the password

```bash
sudo yum whatprovides */mkpasswd
sudo yum install expect
mkpasswd devops
```

Once the new devops has been created successfully. we will generate the SSH keys for the devops user.

change to the devops user.

```bash
ssh-keygen -t rsa -b 4096
```

public and private keys for the devops user has been created. Next, adding the public key to all the remote hosts.

Write a playbook to create a new user, set password and add it to sudoers file on the new hosts.

```bash
ssh -i ~/.ssh/id_rsa ipoftheserver
```

lookup command will try to find the .pub file on the master ansible node for devops user and put that public key in the authorized_keys on the remote servers. Put the .pub file either on your git repo or anywhere on the master node

You need to provide the user ec2-user and the key to connect to the remote host. You need to use the .pem file to connect initially
PEM file need to have specific permission before you can use it directly.

#### How to run the playbook

run the playbook

```bash
ansible-playbook main.yml -i inventories/dev/hosts --user ec2-user --key-file ansible_aut.pem -e '@configs/dev.yml'
```

devops user has created successfully and the public key also get copied to the remote servers

Verify the playbook ran successfully
Try to ssh using devopsuser, if logged in you have successfully setup the ssh key between two servers.

Once you setup the devops user then you can use the devops user public key and run the playbook.

```bash
ansible-playbook main.yml -i inventories/hosts --user devops --key-file /home/devops/.ssh/id_rsa  -e '@configs/dev.yml'
```
