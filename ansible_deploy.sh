#!/bin/bash

# This script installs Homebrew and Ansible, and then checks if Nginx is running on port 80. If not, it runs an Ansible playbook that installs Nginx and verifies its successful installation.

# Install Homebrew
if ( which brew > /dev/null )
then 
  echo -e "\n==== Homebrew installed ====\n"
else 
  echo -e "\n==== Installing homebrew ====\n"
  sudo true; NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Ansible
if ( which ansible > /dev/null )
then 
  echo -e "\n==== Ansible installed ====\n"
else 
  echo -e "\n==== Installing Ansible ====\n"
  brew install ansible
fi

# Run Ansible playbook
if ( curl -I pi.attlocal.net:80 )
then
  echo -e "\n==== Nginx running on port 80 ====\n"
else
  echo -e "\n==== Run Ansible playbook ====\n"
  ansible-playbook -i inventory.ini main_playbook.yaml
fi

