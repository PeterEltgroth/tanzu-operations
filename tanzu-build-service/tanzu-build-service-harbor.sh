read -p "Server (harbor.nycpivot.com): " server
read -p "Project (library): " project
read -p "Repository (build-service): " repository
read -p "Username: " username
read -p "Password: " password
read -p "Pivotal Username: " pivot_username
read -p "Pivotal Password: " pivot_password

sudo docker login registry.pivotal.io -u $pivot_username -p $pivot_password
sudo docker login $server -u $username -p $password

#sudo rm -rf ~/.docker
#sudo mkdir ~/.docker
#sudo cp /root/snap/docker/796/.docker/config.json ~/.docker/config.json

sudo imgpkg copy -b registry.pivotal.io/build-service/bundle:1.2.2 \
	--to-repo ${server}/${project}/${repository} \
	--registry-ca-cert-path /etc/docker/certs.d/${server}/ca.crt
	
sudo imgpkg pull -b ${server}/${project}/${repository}:1.2.2 -o /tmp/bundle \
	--registry-ca-cert-path /etc/docker/certs.d/${server}/ca.crt

sudo ytt -f /tmp/bundle/values.yaml \
    -f /tmp/bundle/config/ \
	-f /etc/docker/certs.d/${server}/ca.crt \
    -v docker_repository=${server}/${project}/${repository} \
    -v docker_username=$username \
    -v docker_password=$password \
    -v tanzunet_username=$pivot_username \
    -v tanzunet_password=$pivot_password \
    | sudo kbld -f /tmp/bundle/.imgpkg/images.yml -f- \
    | kapp deploy -a tanzu-build-service -f- -y

kp clusterbuilder list

kp secret create harbor-registry-secret \
	--registry $server \
	--registry-user $username
