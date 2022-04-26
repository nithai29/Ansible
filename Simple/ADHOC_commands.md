# Ansible ADHOC commands

## Syntax

Syntax for ansible ADHOC commands with SSH key based auth between the control machine and the hosts has been setup.

```bash
ansible <hostgroup> -m <module>  -a <arg>
ansible <hostgroup> -m <module> -a <arg> -i <path_to_hosts_file>
```

## Ping Module

Ping servers

```bash
ansible testservers -m ping 
ansible testservers -m ping -i hosts_file --user=devops --ask-pass
```

## Shell Module

Run commands as root on the hosts

```bash
ansible testservers -m shell -a "cat /etc/passwd | grep devops" -b -K
```

Run commands as a different user  on the hosts

```bash
ansible app -m file -a "path=/opt/oracle/binaries state=directory mode=0755" -i ansible_hosts -b --become-user=weblogic
```

Check the uptime of the servers

```bash
ansible testservers -m shell -a "uptime"
ansible testservers -m command -a "uptime"
ansible testservers -a "uptime"
```

Checking the free memory on the servers

```bash
ansible testservers -m shell -a "free -m"
ansible testservers -m command -a "free -m"
ansible testservers -m "free -m"
```

Checking the disk space on the servers

```bash
ansible testservers -m shell -a "df -h"
ansible testservers -m command -a "df -h"
ansible testservers -m "df -h"
```

Check the date of the servers.

```bash
ansible testservers -m shell -a "date"
```

## User module

Creating a user in linux

```bash
ansible testservers -m user -a "name=devops group=admin createhome=yes" -b 
```

## File Module

Create and change permissions of a directory.

```bash
ansible testservers -m file -a "path=/tmp/tomcat state=directory mode=0755" -b
```

Create and change permissions of a file.

```bash
ansible testservers -m file -a "path=/tmp/devops/testfile state=touch mode=0755"
```

Change ownership of a file

```bash
ansible testservers -m file -a "path=/tmp/devops/testfile group=devops owner=devops" -b
```

## YUM module

Upgrading all packages

```bash
ansible testservers -m yum -a "name='*' state=latest"
```

Installing a package

```bash
ansible testservers -m yum -a "name=httpd state=present"
```

Removing a package

```bash
ansible testservers -m yum -a "name=httpd state=absent"
```

Installing from a remote repo

```bash
ansible testservers -m yum -a "name=http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm state=present"
```

Installing Development tools.

```bash
ansible testservers -m yum -a "name='@Development tools' state=present"
```

## Service Module

Start a service.

```bash
ansible testservers -m service -a "name=httpd status=started"
```

Start and enable a service.

```bash
ansible testservers -m service -a "name=httpd status=started enabled=yes"
```

Stop a service.

```bash
ansible testservers -m service -a "name=httpd status=stop"
```

Check service status

```bash
ansible testservers -m service -a "name=httpd" 
```

## Cron Module

Run the job every 15 minutes

```bash
ansible testservers -s -m cron -a "name='minutes-cron' minute=*/15 job='/path/to/minute-script.sh'"
```

Run the job every four hours

```bash
ansible testservers -s -m cron -a "name='every-four-hours-cron' hour=4 job='/path/to/hour-script.sh'"
```

Enabling a Job to run at system reboot

```bash
ansible testservers -s -m cron -a "name='reboot-all-servers' special_time=reboot job='/path/to/startup-script.sh'"
```

Scheduling a Daily job

```bash
ansible testservers -s -m cron -a "name='daily-cron' special_time=daily job='/path/to/daily-script.sh'"
```

Scheduling a Weekly job

```bash
ansible multi -s -m cron -a "name='weekly-cron' special_time=weekly job='/path/to/weekly-script.sh'"
```

## Setup Module

Display system information

```bash
ansible testservers -m setup 
```

## Listen_ports_facts module

Display listening ports

```bash
ansible testserver -m listen_ports_facts
```
