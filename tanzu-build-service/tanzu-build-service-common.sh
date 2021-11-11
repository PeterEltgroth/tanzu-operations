read -p "Server: " server
read -p "Repository (build-service): " repository
read -p "Username: " username
read -p "Password: " password
read -p "Pivot Username: " pivot_username
read -p "Pivot Password: " pivot_password

sudo docker login registry.pivotal.io -u $pivot_username -p $pivot_password
sudo docker login $server -u $username -p $password


sudo imgpkg copy -b registry.pivotal.io/build-service/bundle:1.2.2 --to-repo ${server}/${repository}
	
sudo imgpkg pull -b ${server}/${repository}:1.2.2 -o /tmp/bundle

sudo ytt -f /tmp/bundle/values.yaml \
    -f /tmp/bundle/config/ \
    -v docker_repository=${server}/${repository} \
    -v docker_username=$username \
    -v docker_password=$password \
    -v tanzunet_username=$pivot_username \
    -v tanzunet_password=$pivot_password \
    | sudo kbld -f /tmp/bundle/.imgpkg/images.yml -f- \
    | kapp deploy -a tanzu-build-service -f- -y

kp clusterbuilder list

kp secret create common-registry-secret \
	--registry $server \
	--registry-user $username
