#APP LIVEVIEW
cat <<EOF | tee app-live-view-backend-values.yaml
ingressDomain: appliveview.apps.tap.nycpivot.com
EOF

tanzu package install appliveview -p backend.appliveview.tanzu.vmware.com -v 1.3.0 -n tap-install -f app-live-view-backend-values.yaml
tanzu package installed get appliveview -n tap-install


#CONNECTOR
cat <<EOF | tee app-live-view-connector-values.yaml
backend:
    host: appliveview.apps.tap.nycpivot.com
EOF

tanzu package install appliveview-connector -p connector.appliveview.tanzu.vmware.com -v 1.3.0 -n tap-install -f app-live-view-connector-values.yaml
tanzu package installed get appliveview-connector -n tap-install


#CONVENTIONS
tanzu package install appliveview-conventions -p conventions.appliveview.tanzu.vmware.com -v 1.3.0 -n tap-install
tanzu package installed get appliveview-conventions -n tap-install
