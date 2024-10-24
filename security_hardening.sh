#!/bin/bash

echo "Starting Linux Server Automation & Security Hardening..."

# Disable root login via SSH
echo "Disabling root login via SSH"
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# Enforce password policies
echo "Setting password complexity and expiration policies"
sed -i '/PASS_MAX_DAYS/c\PASS_MAX_DAYS 90' /etc/login.defs
sed -i '/PASS_MIN_DAYS/c\PASS_MIN_DAYS 7' /etc/login.defs
sed -i '/PASS_WARN_AGE/c\PASS_WARN_AGE 7' /etc/login.defs
echo "auth required pam_tally2.so onerr=fail deny=5 unlock_time=1800" >> /etc/pam.d/common-auth

# Install and configure UFW
echo "Installing and configuring UFW firewall"
apt-get install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw enable

# Install updates and security patches
echo "Installing updates and security patches"
apt-get update -y && apt-get upgrade -y

# Set permissions on critical files
echo "Setting permissions on critical system files"
chmod 600 /etc/passwd
chmod 600 /etc/shadow

# Add user 'admin' with sudo privileges
echo "Adding user 'admin' with sudo privileges"
useradd -m -s /bin/bash admin
echo "admin:password" | chpasswd
usermod -aG sudo admin

echo "Linux Server Automation & Security Hardening Completed."
