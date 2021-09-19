read -p "Harbor Server (core.harbor.domain): " harbor_server
read -p "Harbor Project: " harbor_project
read -p "Harbor Repository Name (build-service): " harbor_repository
read -p "Harbor Username: " harbor_username
read -p "Harbor Password: " harbor_password
read -p "Pivotal Username: " pivot_username
read -p "Pivotal Password: " pivot_password

sudo docker login registry.pivotal.io -u $pivot_username -p $pivot_password
sudo docker login $harbor_server -u $harbor_username -p $harbor_password

#sudo rm -rf ~/.docker
#sudo mkdir ~/.docker
#sudo cp /root/snap/docker/796/.docker/config.json ~/.docker/config.json

sudo imgpkg copy -b registry.pivotal.io/build-service/bundle:1.2.2 \
	--to-repo ${harbor_server}/${harbor_project}/${harbor_repository} \
	--registry-ca-cert-path /etc/docker/certs.d/${harbor_server}/ca.crt
	
sudo imgpkg pull -b ${harbor_server}/${harbor_project}/${harbor_repository}:1.2.2 -o /tmp/bundle \
	--registry-ca-cert-path /etc/docker/certs.d/${harbor_server}/ca.crt

sudo ytt -f /tmp/bundle/values.yaml \
    -f /tmp/bundle/config/ \
	-f /etc/docker/certs.d/${harbor_server}/ca.crt \
    -v docker_repository=${harbor_server}/${harbor_project}/${harbor_repository} \
    -v docker_username=$harbor_username \
    -v docker_password=$harbor_password \
    -v tanzunet_username=$pivot_username \
    -v tanzunet_password=$pivot_password \
    | sudo kbld -f /tmp/bundle/.imgpkg/images.yml -f- \
    | kapp deploy -a tanzu-build-service -f- -y

#sudo kp import -f descriptor-100.0.150.yaml --show-changes

kp clusterbuilder list

kp secret create harbor-registry-secret \
	--registry $harbor_server \
	--registry-user $harbor_username
