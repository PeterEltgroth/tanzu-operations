sudo apt update
yes | sudo apt upgrade

#MISC
sudo snap install jq
sudo apt install unzip

cat <<EOF | tee bootstrapper-files.txt
{
	prereqs: https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/01-operator-prereqs.sh,
	tap: https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tap-operations/scripts-bootstrapper.sh,
	tbs: https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tbs-operations/scripts-bootstrapper.sh,
	tkg: https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/scripts-bootstrapper.sh,
	tmc: https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/scripts-bootstrapper.sh,
	tsm: https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/scripts-bootstrapper.sh
}
EOF

#AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

aws configure

