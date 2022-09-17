tanzu apps workload create tanzu-scg-web-app --git-repo https://github.com/nycpivot/tanzu-scg-web-app --git-branch main --type web --label app.kubernetes.io/part-of=tanzu-scg-web-app --yes --annotation autoscaling.knative.dev/min-scale=1

#tanzu apps workload create steeltoe-app --type web --git-repo https://github.com/sample-accelerators/steeltoe-weatherforecast --git-branch main --annotation autoscaling.knative.dev/min-scale=1 --yes --label app.kubernetes.io/part-of=sample-app
