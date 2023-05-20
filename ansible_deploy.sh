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

# Dynamically add IP to inventory.ini file if Pi is running
if ( ping -c 1 $PI_HOST )
then
  echo -e "\n==== RaspberryPI server running ====\n"
  if [ -f inventory.ini ]
  then 
    echo -e "\n=== Inventory.ini file present ====\n"
  else
    echo -e "\n=== Create inventory.ini file  ====\n"
cat <<-EOF > inventory.ini
[raspberrypi]
$PI_HOST ansible_user=$USER
EOF
  fi
else 
  echo -e "\n==== RaspberryPI server not running ====\n"
fi

# Run main playbook
if [ -f inventory.ini ]
then
  echo -e "\n==== Running main playbook ====\n"
  ansible-playbook -i inventory.ini main_playbook.yaml
else
  echo -e "\n==== Inventory file not present ====\n"
fi