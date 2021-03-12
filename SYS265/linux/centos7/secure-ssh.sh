#secure-ssh.sh
#author nicolashall8
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in
#!/bin/bash
echo Type in a Username:
read uname
sudo useradd -m -d /home/$uname -s /bin/bash $uname
sudo mkdir /home/$uname/.ssh
sudo cp ~/tech-journal/SYS265/linux/public-keys/id_rsa.pub /home/$uname/.ssh/authorized_keys
sudo chmod 700 /home/$uname/.ssh
sudo chmod 600 /home/$uname/.ssh/authorized_keys
sudo chown -R $uname:$uname /home/$uname/.ssh
