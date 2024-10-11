#!/bin/bash

# Create the user with a home directory and set their default shell
useradd -m -s /bin/bash ansible_user

# Set the password for ansible_user interactively
echo "Set password for the new user ansible_user:"
passwd ansible_user

# Add the user to the sudo group
usermod -aG sudo ansible_user

# Create the .ssh directory for ansible_user and set the correct permissions
mkdir -p /home/ansible_user/.ssh
chmod 700 /home/ansible_user/.ssh

# Copy the root's public key to the ansible_user's authorized_keys
if [ -f /root/.ssh/authorized_keys ]; then
    cp /root/.ssh/authorized_keys /home/ansible_user/.ssh/authorized_keys
    chmod 600 /home/ansible_user/.ssh/authorized_keys
    chown -R ansible_user:ansible_user /home/ansible_user/.ssh
    echo "Copied root's public key to ansible_user's authorized_keys."
else
    echo "Root's public key not found. Please ensure that /root/.ssh/authorized_keys exists."
fi

echo "User 'ansible_user' has been created, added to the sudo group, and configured for SSH access."

