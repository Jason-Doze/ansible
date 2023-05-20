#!/bin/bash

# Delete fingerprints from known_hsots
if ( grep -q "$(dig +short pi.attlocal.net)" ~/.ssh/known_hosts ) 
then
  echo -e "\n==== Deleting fingerprint in known_hosts ====\n"
  ssh-keygen -R $(dig +short pi.attlocal.net)
else
  echo -e "\n==== Fingerprint not present in known_hosts ====\n"
fi

# Shutdown Pi
if ( dig +short pi.attlocal.net )
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