read -p "App Name: " app_name
read -p "Git App Url: " git_app_url

for i in {1..100}
do
   tanzu apps workload create ${app_name}-${i} --git-repo ${git_app_url} --git-branch main --type web --label app.kubernetes.io/part-of=${app_name}-${i} --yes
   sleep 10
done
