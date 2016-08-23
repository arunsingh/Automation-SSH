#!/bin/bash
#Author:Kiran
#Date: AUG 22/2016
user=$1
task=$2
home_dir="/home/$user"
keypath="/home/$1/.ssh/"
authorized_path="/home/$1/.ssh/authorized_keys"
id_rsa="/home/$1/.ssh/$user"
id_rsa_pub="/home/$1/.ssh/$user.pub"

#puprose of the function is to create a user and provide user access with a key
create_user(){
user1=$1
useradd $user1
su -l $user1 -c ssh-keygen <<EOT
$user
EOT
mkdir $keypath
mv $home_dir/$user* $keypath
touch $authorized_path
cat $id_rsa_pub >$authorized_path
chown $user.$user $keypath $authorized_path
chmod 600 $authorized_path 
restart_ssh
}

#default_certs(){
   

#}
#
#Restarting SSH Service to update
restart_ssh(){
	dpkg="/usr/bin/dpkg"
	yum_="/use/bin/yum"

	if [ -f $dpkg ]
		then
/etc/init.d/ssh restart
   else
/usr/bin/systemctl restart sshd	
fi

}

if [ $# -eq 2 ]
        then
        if [ "$task" = "G" ]
                then 
                echo "Granting SSH access to $user"
        #echo "$id_rsa"
                create_user $user
                echo "Use this key to access the server"
                echo "##############################"
                echo "Access key for $username"
                cat $id_rsa
       fi
		if [ "$task" = "R" ]
        		then
        		echo "Revoking SSH Access to $user"
        		rm -f $user $authorized_path
       fi

else
        echo " Two inputs required"
        echo " 1) Username"
        echo " 2) G or R ( 'G' for GRANT SSH access Or 'R' for Revoke SSH access) "
fi
