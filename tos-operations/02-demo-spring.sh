read -p "Repository Name: " repo_name

if [ -z $repo_name ]
then
	repo_name=tanzu-spring-petclinic
fi

cd tos
rm -rf $repo_name

git clone https://github.com/nycpivot/${repo_name}
