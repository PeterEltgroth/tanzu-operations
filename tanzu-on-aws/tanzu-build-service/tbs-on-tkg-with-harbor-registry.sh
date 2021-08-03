read -p "Harbor Server: " harbor_server
read -p "Harbor Project: " harbor_project
read -p "Harbor Repository Name (tbsimages): " harbor_repository
read -p "Harbor Username: " harbor_username
read -p "Harbor Password: " harbor_password
read -p "Pivotal Username: " pivot_username
read -p "Pivotal Password: " pivot_password


sudo docker login registry.pivotal.io -u $pivot_username -p $pivot_password
sudo docker login $harbor_server -u $harbor_username -p $harbor_password

sudo kbld relocate -f /tmp/images.lock \
		--lock-output /tmp/images-relocated.lock \
		--repository ${harbor_server}/${harbor_project}/${harbor_repository}
		--registry-verify-certs=false

sudo ytt -f /tmp/values.yaml \
    -f /tmp/manifests/ \
    -v docker_repository=${harbor_server}/${harbor_project}/${harbor_repository} \
    -v docker_username=$harbor_username \
    -v docker_password=$harbor_password \
    | sudo kbld -f /tmp/images-relocated.lock -f- \
    | sudo kapp deploy -a $harbor_project -f- -y

sudo kp import -f descriptor-100.0.60.yaml

kp clusterbuilder list

kp secret create harbor-registry-secret \
	--registry $harbor_server \
	--registry-user $harbor_username

