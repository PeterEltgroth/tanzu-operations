read -p "Repository Url: " repo_url

tanzu accelerator create simple --git-repository $repo_url --git-branch main
