sudo apt update
yes | sudo apt upgrade

#MISC
sudo snap install jq
sudo apt install unzip

cat <<EOF | tee operator-bootstrapper.sh
read -p "Operator Prefix: " operator_prefix

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/01-operator-prereqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/10-operator-prereqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/11-image-create-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/11-snapshot-create-us-east-2.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/${operator_prefix}-operations/scripts-bootstrapper.sh
EOF

#AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

aws configure

