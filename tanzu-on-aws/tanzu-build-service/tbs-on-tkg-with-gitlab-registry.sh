read -p "GitLab Server: " gitlab_server
read -p "GitLab Repository (.../tbsimages): " gitlab_repository
read -p "GitLab Username: " gitlab_username
read -p "GitLab Password: " gitlab_password
read -p "Pivotal Username: " pivot_username
read -p "Pivotal Password: " pivot_password


sudo docker login registry.pivotal.io -u $pivot_username -p $pivot_password
sudo docker login $gitlab_server -u $gitlab_username -p $gitlab_password

sudo kbld relocate -f /tmp/images.lock \
		--lock-output /tmp/images-relocated.lock \
		--repository ${gitlab_server}/${gitlab_repository}

sudo ytt -f /tmp/values.yaml \
    -f /tmp/manifests/ \
    -v docker_repository=${gitlab_server}/${gitlab_repository} \
    -v docker_username=$gitlab_username \
    -v docker_password=$gitlab_password \
    | sudo kbld -f /tmp/images-relocated.lock -f- \
    | sudo kapp deploy -a tanzu-build-service -f- -y

sudo kp import -f descriptor-100.0.60.yaml

kp clusterbuilder list

kp secret create gitlab-registry-secret \
	--registry $gitlab_server \
	--registry-user $gitlab_username
