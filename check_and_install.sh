#!/bin/bash

# Check if Python is installed
if [ -x "$(command -v python3)" ]; then
  echo "Python is installed."
else
  echo "Python is not installed. Installing Python..."
  sudo apt-get update
  sudo apt-get install -y python3
fi

# Check if pip is installed
if [ -x "$(command -v pip3)" ]; then
  echo "pip is installed."
else
  echo "pip is not installed. Installing pip..."
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py --user
  rm get-pip.py
fi

# Check if Ansible is installed
if [ -x "$(command -v ansible)" ]; then
  echo "Ansible is installed."
else
  echo "Ansible is not installed. Installing Ansible..."
  python3 -m pip install --user ansible
fi

python3_version=$(python3 --version)
pip3_version=$(python3 -m pip -V)
ansible_version=$(ansible --version)
echo "Python and Ansible are both installed."
echo "$python3_version"
echo "$pip3_version"
echo "$ansible_version"
