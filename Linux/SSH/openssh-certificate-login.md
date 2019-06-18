# How to setup ssh to use certificate login

## Ensure openssh-server is installed on your linux machine
sudo apt install openssh-server

## Generate public-private key pair (in MobaXterm)
launch an local terminal and execute the following command "ssh-keygen -t rsa"

## Copy the public key to your linux machine (user@host)
cat ~/.ssh/id_rsa.pub | ssh user@host "cat - >> ~/.ssh/authorized_keys"

## Configure your ssh client (in this case MobaXterm) to use the private key

### At this point, you should be able to login to your linux machine using your private key
