FROM ubuntu

RUN apt-get update

WORKDIR /tmp

COPY tanzu-cli-bundle-linux-amd64-v1.5.1.tar .
RUN tar -xvf tanzu-cli-bundle-linux-amd64-v1.5.1.tar
RUN rm tanzu-cli-bundle-linux-amd64-v1.5.1.tar

RUN install cli/core/v0.11.1/tanzu-core-linux_amd64 /usr/local/bin/tanzu

RUN tanzu init

#PLUGINS
RUN tanzu plugin clean
RUN tanzu plugin sync
RUN tanzu plugin list


#CARVEL (YTT, KAPP, KBLD, IMGPKG)
RUN gunzip cli/ytt-linux-amd64-v0.35.1+vmware.1.gz
RUN chmod ugo+x cli/ytt-linux-amd64-v0.35.1+vmware.1
RUN mv cli/ytt-linux-amd64-v0.35.1+vmware.1 /usr/local/bin/ytt

RUN gunzip cli/kapp-linux-amd64-v0.42.0+vmware.1.gz
RUN chmod ugo+x cli/kapp-linux-amd64-v0.42.0+vmware.1
RUN mv cli/kapp-linux-amd64-v0.42.0+vmware.1 /usr/local/bin/kapp

RUN gunzip cli/kbld-linux-amd64-v0.31.0+vmware.1.gz
RUN chmod ugo+x cli/kbld-linux-amd64-v0.31.0+vmware.1
RUN mv cli/kbld-linux-amd64-v0.31.0+vmware.1 /usr/local/bin/kbld

RUN gunzip cli/imgpkg-linux-amd64-v0.18.0+vmware.1.gz
RUN chmod ugo+x cli/imgpkg-linux-amd64-v0.18.0+vmware.1
RUN mv cli/imgpkg-linux-amd64-v0.18.0+vmware.1 /usr/local/bin/imgpkg

ENV AWS_ACCESS_KEY_ID=AKIA6BLJXPDVKQQLDE7K
ENV AWS_SECRET_ACCESS_KEY=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
ENV AWS_DEFAULT_REGION=us-east-1
ENV MGMT_CLUSTER_NAME=tanzu-management-cluster

COPY tanzu-management-cluster-dev.sh .
