#!/bin/bash

# Shutdown Pi
if ( ping -c 1 $PI_HOST )
then 
  echo -e "\n==== Pi server running ====\n"
  ansible-playbook -i inventory.ini shutdown_pi.yaml
else
  echo -e "\n==== Pi server not running ====\n"
fi

# Delete inventory.ini file
if [ -f inventory.ini ]
then
  echo -e "\n==== Deleting inventory.ini file ====\n"
  rm inventory.ini
else
  echo -e "\n==== Inventory.ini file not present ====\n"
fi

# Delete ansible.cf file
if [  -f ansible.cfg ]
then
  echo -e "\n==== Deleting ansible.cfg file ====\n"
  rm ansible.cfg
else
  echo -e "\n==== Ansible.cfg not present ====\n"
fi

# Delete fingerprints from known_hosts
if ( grep -q $PI_HOST ~/.ssh/known_hosts ) 
then
  echo -e "\n==== Deleting fingerprint in known_hosts ====\n"
  ssh-keygen -R $PI_HOST
else
  echo -e "\n==== Fingerprint not present in known_hosts ====\n"
fi