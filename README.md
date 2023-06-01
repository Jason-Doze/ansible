# Ansible | Nginx | NodeJS | Deployment Script 

This repository contains scripts and Ansible playbooks to setup and manage a Raspberry Pi server running Nginx. It includes scripts to deploy the setup and to tear it down using a MacOS.


## Prerequisites
Before using the scripts and Ansible playbooks in this repository, make sure you have the following:

1. You should have SSH access to the Raspberry Pi server. The scripts and playbooks will interact with the server via SSH.

2. The Raspberry Pi server must have its hostname set to "pi". This is essential as the scripts use this hostname to resolve the server's IP address.

## Structure

This project is composed of seven main files:
1. `ansible_deploy.sh`: A bash script that handles the installation of Homebrew and Ansible on your local computer. It also determines if Nginx is running on the RaspberryPi. If not, it triggers an Ansible playbook to install and validate Nginx.
2. `inventory.ini`: This file will be dynamically created by the `ansible_deploy.sh` script to specify the IP address and username of the Raspberry Pi server.
3. `main_playbook.yaml`: This is the main playbook. It includes tasks from `install_nginx.yaml`, `nginx_test.yaml`, `install_nodejs.yaml`, and `nodejs_test.yaml`.
4. `install_nginx.yaml`: This playbook contains tasks that install the latest version of Nginx on the target host.
5. `nginx_test.yaml`: This playbook contains tasks that check if Nginx has been installed on the target host.
6. `install_nodejs.yaml`: This playbook contains tasks that install the latest version of NodeJS on the target host.
7. `nodejs_test.yaml`: This playbook contains tasks that check if NodeJS has been installed on the target host.
8. `shutdown_pi.yaml`: This Ansible playbook includes a task to shut down the Raspberry Pi server.
9. `ansible_destroy.sh`: This bash script removes the SSH fingerprint of the Raspberry Pi server from your known_hosts file, triggers a playbook to shut down the Raspberry Pi, and deletes the inventory file.

## Usage

* Run the Main Ansible playbook:

```bash
PI_HOST=$(dig +short pi | tail -n1) bash ansible_deploy.sh
```

* Run the destroy script:
```bash
PI_HOST=$(dig +short pi | tail -n1) bash ansible_destroy.sh
```
