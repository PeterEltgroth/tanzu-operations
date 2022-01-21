tanzu apps workload delete --all
echo

tanzu apps workload list
echo

kubectl patch packageinstall -n tap-install tap -p '{"spec": {"paused": true}}' --type=merge
kubectl delete packageinstall -n tap-install services-toolkit #wait til it is gone
kubectl patch packageinstall -n tap-install tap -p '{"spec": {"paused": false}}' --type=merge
