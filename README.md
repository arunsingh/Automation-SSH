# Automation-SSH
Automate the process of Granting/Revoking SSH access to servers

This project is used for Automating the process of Granting /Revoking SSH access.
Means, when you execute this script with two parameters (user and G/R (G is for grant ssh access, R is for revoke)) ,it will 
-> Create a user
-> Do the ssh-keygen and generate public and private keys
-> Create a Authorized_keys file and push the public key to it
-> finally restart the sshd service.

I am using asible playbook to send the paramerters to it.

