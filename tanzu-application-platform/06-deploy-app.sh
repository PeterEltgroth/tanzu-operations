read -p "App Name: " app_name
read -p "Git App Url: " git_app_url

tanzu apps workload create $app_name \
--git-repo $git_app_url \
--git-branch main \
--type web \
--label app.kubernetes.io/part-of=tanzu-java-web-app \
--yes
#tanzu apps workload create $app_name --git-repo $git_app_url --git-branch main --type web --label app.kubernetes.io/part-of=tanzu-java-web-app --yes

tanzu apps workload tail $app_name --since 10m --timestamp