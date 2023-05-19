# Ansible Nginx Deployment Script 

This repository contains the necessary scripts and Ansible playbooks for deploying and managing an Nginx server on a Raspberry Pi 400 from MacOS.

## Structure

This project is composed of five main files:
1. `ansible_deploy.sh`: A bash script that handles the installation of Homebrew and Ansible. It also determines if Nginx is running on port 80. If not, it triggers an Ansible playbook to install and validate Nginx.
2. `inventory.ini`: This file lists the target hosts for the playbooks. The hosts are grouped under the alias `raspberrypi`.
3. `main_playbook.yaml`: This is the main playbook. It includes tasks from `install_nginx.yaml` and `nginx_test.yaml`.
4. `install_nginx.yaml`: This playbook contains tasks that install the latest version of Nginx on the target host.
5. `nginx_test.yaml`: This playbook contains tasks that check if Nginx has been installed on the target host.


## Usage

* You should have SSH access to the target hosts specified in `inventory.ini`.

* Edit the inventory file: Replace `pi.attlocal.net` with the hostname or IP address of your Raspberry Pi in `inventory.ini`. 

* Run the Main Playbook: Use the following command to run the main playbook:

```bash
bash ansible_deploy.sh
```

This script will install Homebrew and Ansible if they are not installed. Then it will check if Nginx is running on port 80. If not, it will run the Ansible playbook which installs and validates Nginx is running on the Raspberry Pi.
