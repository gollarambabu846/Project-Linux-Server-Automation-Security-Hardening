# Project Linux-Server-Automation-Security-Hardening


The Linux Server Automation & Security Hardening project involves automating the process of securing a Linux server. This project helps to enforce security policies, reduce vulnerabilities, and ensure the server is hardened against attacks.

Overview of the Project:
Automation: You will use automation scripts to implement security policies such as user management, package updates, firewall setup, and SSH hardening.
Security Hardening: You'll apply security best practices like disabling root login, enforcing password policies, managing permissions, installing security patches, and configuring firewall rules.
Steps for Project Execution:
Server Setup:

Set up a Linux environment (Ubuntu, CentOS, or any other distribution) either on a local virtual machine or in the cloud (AWS, Azure).
Ensure you have root or sudo access to perform administrative tasks.
Create Automation Script:

Write a shell script (security_hardening.sh) that automates various security tasks.
Project Breakdown:
Step 1: Disable Root Login via SSH
To prevent root from accessing the server via SSH:

Edit the SSH configuration file to disable root login.
bash
Copy code
#!/bin/bash

# Disable root SSH login
echo "Disabling root login via SSH"
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd
Step 2: Enforce Password Policy
Set password complexity, expiration, and lockout policies using pam:

bash
Copy code
# Enforce password policies
echo "Setting password complexity and expiration policies"
sed -i '/PASS_MAX_DAYS/c\PASS_MAX_DAYS 90' /etc/login.defs
sed -i '/PASS_MIN_DAYS/c\PASS_MIN_DAYS 7' /etc/login.defs
sed -i '/PASS_WARN_AGE/c\PASS_WARN_AGE 7' /etc/login.defs

# Configure pam for lockout after failed attempts
echo "auth required pam_tally2.so onerr=fail deny=5 unlock_time=1800" >> /etc/pam.d/common-auth
Step 3: Configure UFW Firewall
Install and configure UFW to allow only necessary ports (e.g., SSH on port 22, HTTP on port 80).

bash
Copy code
# Install and configure UFW
echo "Installing and configuring UFW firewall"
apt-get install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw enable
Step 4: Install Updates and Security Patches
Automate package updates and install security patches:

bash
Copy code
# Install updates and security patches
echo "Installing updates and security patches"
apt-get update -y && apt-get upgrade -y
Step 5: Set File Permissions
Restrict file access by setting correct file permissions for critical system files.

bash
Copy code
# Set permissions on critical files
echo "Setting permissions on critical system files"
chmod 600 /etc/passwd
chmod 600 /etc/shadow
Step 6: User Management Automation
Automate the process of adding users, removing users, or setting up specific permissions.

bash
Copy code
# Add a user with sudo privileges
echo "Adding user 'admin' with sudo privileges"
useradd -m -s /bin/bash admin
echo "admin:password" | chpasswd
usermod -aG sudo admin
Complete Script Example:
bash
Copy code
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
Step 7: Make the Script Executable
Ensure the script has executable permissions:

bash
Copy code
chmod +x security_hardening.sh
Step 8: Run the Script
To execute the script, run it with sudo:

bash
Copy code
sudo ./security_hardening.sh
Step 9: Verify the Output
SSH Configuration: Try to SSH into the server as root, and you should get an access denied message.

Password Policy: Try creating or changing a user’s password and check if it follows the enforced policies.

Firewall: Test the firewall by trying to access different ports that should be blocked.

Updates: Check for installed package updates using apt list --upgradable.

User Management: Ensure the user 'admin' is created and has sudo access.

Conclusion:
This project provides a foundation for automating essential Linux server security hardening practices. You can extend this project by adding more security features such as log monitoring, intrusion detection (using tools like fail2ban), or configuring SELinux for added security.






Linux Server Automation & Security Hardening is a project aimed at automating the process of securing a Linux server. The core idea is to minimize manual effort and ensure that the server is configured in a way that reduces vulnerabilities, enhances security, and meets best practices for system administration.

Here's a breakdown of the key concepts:

1. Linux Server Automation:
Automation refers to the process of using scripts, tools, or software to perform repetitive tasks without human intervention. In the context of this project, it involves writing shell scripts or using configuration management tools (like Ansible, Chef, or Puppet) to automate tasks like:
Creating users and assigning permissions.
Installing updates and patches.
Configuring firewalls and security tools.
Monitoring system performance.
This saves time, reduces human error, and ensures consistency across multiple servers.

2. Security Hardening:
Security Hardening is the process of making a system more secure by:
Reducing the attack surface (i.e., the number of ways a system can be attacked).
Implementing security best practices to protect sensitive data, resources, and services.
Fixing vulnerabilities that could be exploited by attackers.
Common hardening techniques include: - Disabling unnecessary services and ports. - Applying regular updates and patches to fix security bugs. - Configuring secure password policies and user access controls. - Enforcing network-level security through firewalls.

Goals of the Project:
Automate Essential Tasks: Tasks such as user management, patch management, SSH configuration, and firewall rules are automated using scripts.
Ensure Security: The server is secured by implementing measures like password complexity, disabling root login, and applying file permission policies.
Consistency: Automation ensures that every server in a network is set up in a uniform and secure manner.
Key Components in This Project:
User Management:

Automating the creation of users, assigning roles, and setting password policies to ensure secure access.
Password and Authentication Policies:

Enforcing password complexity, expiration rules, and lockout policies to prevent unauthorized access.
SSH Hardening:

Configuring SSH to disable root login and use key-based authentication for secure remote access.
Firewall Configuration:

Setting up a firewall (e.g., UFW, iptables) to block unnecessary ports and restrict access to critical services.
System Updates & Patching:

Automating the installation of system updates and security patches to ensure vulnerabilities are quickly addressed.
File Permissions & Ownership:

Ensuring that critical system files have the right permissions to prevent unauthorized access or tampering.
Monitoring & Logging:

Automating system logs and monitoring to track and audit system activities and potential security incidents.
Example:
In this project, you might write a script to automatically:

Update the system’s software packages to apply security patches.
Disable root login via SSH to reduce risk.
Set up firewalls to allow only specific connections (e.g., SSH on port 22).
Enforce password policies like minimum length, complexity, and expiration time.
Why is This Important?
Improved Security: Hardening ensures the system is resistant to common attacks.
Efficiency: Automating these tasks ensures they are applied consistently across multiple systems without human error.
Compliance: Many industries require systems to meet certain security standards, and automation helps ensure that servers comply with these requirements.
