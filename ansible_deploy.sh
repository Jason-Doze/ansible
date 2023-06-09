#!/bin/bash

# This script installs Homebrew and Ansible, and then checks if the Pi Server is running. If so, it runs an Ansible playbook that installs Nginx, NodeJS and verifies its successful installation.

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

# Set strict host key checking to no.
if [  -f ansible.cfg ]
then
  echo -e "\n==== Ansible.cfg present ====\n"
else
  echo -e "\n==== Creating ansible.cfg file ====\n"
  cat <<- EOF > ansible.cfg
[defaults]
host_key_checking = False
EOF
fi

# Dynamically add IP to inventory.ini file if Pi is running
if ( ping -c 1 $PI_HOST )
then
  echo -e "\n==== RaspberryPI server running ====\n"
  if [ -f inventory.ini ]
  then 
    echo -e "\n==== Inventory.ini file present ====\n"
  else
    echo -e "\n==== Create inventory.ini file  ====\n"
    cat <<- EOF > inventory.ini
[raspberrypi]
$PI_HOST ansible_user=$USER
EOF
  fi
   # Run main playbook
  if [ -f inventory.ini ]
  then
    echo -e "\n==== Running main playbook ====\n"
    ansible-playbook -i inventory.ini main_playbook.yaml
  fi
else 
  echo -e "\n==== RaspberryPI server not running ====\n"
fi