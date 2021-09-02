sudo apt update
yes | sudo apt upgrade
yes | sudo apt install docker.io
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker $USER

#echo REBOOT
#docker --version
#docker run hello-world
  
#sudo snap install docker
#sudo groupadd docker
#sudo usermod -aG docker $USER
##newgrp docker

#HELM
sudo snap install helm --classic

#JQ
sudo snap install jq

#AWS CLI, CLUSTERAWSADM
sudo apt install unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip


#GCLOUD CLI
sudo snap install google-cloud-sdk --classic

gcloud auth login
gcloud config set project pa-mjames


#AZ CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
read -p "Azure Subscription: " subscription

az login
az account set --subscription $subscription


#DEMO-MAGIC
wget https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh
sudo mv demo-magic.sh /usr/local/bin/demo-magic.sh
chmod +x /usr/local/bin/demo-magic.sh

sudo apt install pv #required for demo-magic

echo "REBOOT TO START DOCKER SERVICE"
