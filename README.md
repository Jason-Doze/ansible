# Ansible Playbook for Nginx Setup

This project includes a set of Ansible playbooks that automate the installation of the Nginx web server on a Raspberry Pi, and subsequently test whether the installation was successful.

## Structure

This project is composed of three main files:

1. `main_playbook.yaml`: This is the main playbook. It includes tasks from `install_nginx.yaml` and `nginx_test.yaml`.
2. `install_nginx.yaml`: This playbook contains tasks that install the latest version of Nginx on the target hosts.
3. `nginx_test.yaml`: This playbook contains tasks that check whether Nginx has been installed on the target hosts.

In addition, there is an inventory file:

- `inventory.ini`: This file lists the target hosts for the playbooks. The hosts are grouped under the alias `raspberrypi`.

## Usage

You need to have Ansible installed on your control machine to run these playbooks. In addition, you should have SSH access to the target hosts specified in `inventory.ini`.

The commands below assume that you have cloned the repository and are in the root directory of the project.

1. **Edit the inventory file:** Replace `pi.attlocal.net` with the hostname or IP address of your Raspberry Pi in `inventory.ini`. If necessary, change the `ansible_user` value to the user on the Raspberry Pi with sudo privileges.

2. **Run the Main Playbook:** Use the following command to run the main playbook:

   ```bash
   ansible-playbook -i inventory.ini main_playbook.yaml

3. This command will trigger the tasks in main_playbook.yaml, which in turn will install Nginx on the target hosts and test whether the installation was successful.

4. Please ensure that the user specified in ansible_user has the necessary permissions to install packages on the target hosts.