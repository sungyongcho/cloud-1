#!/bin/bash

echo "Uninstalling Ansible and pip3..."

# Uninstall Ansible using pip
sudo pip3 uninstall ansible -y

# Uninstall pip3
sudo apt-get remove python3-pip -y

echo "Ansible and pip3 have been uninstalled."
