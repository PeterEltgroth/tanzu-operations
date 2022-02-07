#ssh-keygen -t rsa -b 2048 -C "mijames@vmware.com"
#ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

kubectl create secret generic git-ssh --type kubernetes.io/ssh-auth --from-file=ssh-privatekey=.ssh/id_rsa --from-file=known_hosts=.ssh/known_hosts --from-file=identity=.ssh/id_rsa --from-file=identity.pub=.ssh/id_rsa.pub -n default

kubectl annotate secret git-ssh tekton.dev/git-0=github.com

#GIT-SSH
#1. ssh-keygen -t rsa
#2. vim .ssh/id_rsa.pub -> copy it to the git repo https://github.com/dhadukk/tanzu-java-web-app-latest/settings/keys
#3. ssh-keyscan github.com > ./known_hosts
#4. kubectl create secret generic git-ssh --from-file=ssh-privatekey=.ssh/id_rsa --from-file=known_hosts=.ssh/known_hosts --from-file=identity=.ssh/id_rsa --from-file=identity.pub=.ssh/id_rsa.pub -n default
