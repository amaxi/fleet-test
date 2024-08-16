#!/bin/bash
export PATH=/sbin:/usr/sbin:/usr/local/sbin:/root/bin:/usr/local/bin:/usr/bin:/bin:/var/lib/rancher/rke2/bin:/opt/rke2/bin:/var/lib/rancher/rke2/bin:/opt/rke2/bin

# Get the latest rev
rev=$(kubectl -n kube-system exec $(kubectl -n kube-system get pod -l component=etcd --no-headers -o custom-columns=NAME:.metadata.name | head -1) – etcdctl --cert /var/lib/rancher/rke2/server/tls/etcd/server-client.crt --key /var/lib/rancher/rke2/server/tls/etcd/server-client.key --cacert /var/lib/rancher/rke2/server/tls/etcd/server-ca.crt endpoint status --write-out fields | grep Revision | cut -d: -f2)# run compact on the latest rev

#run compact on the latest rev
kubectl -n kube-system exec $(kubectl -n kube-system get pod -l component=etcd --no-headers -o custom-columns=NAME:.metadata.name | head -1) – etcdctl --cert /var/lib/rancher/rke2/server/tls/etcd/server-client.crt --key /var/lib/rancher/rke2/server/tls/etcd/server-client.key --cacert /var/lib/rancher/rke2/server/tls/etcd/server-ca.crt compact $rev# run defrag

#run defrag
kubectl -n kube-system exec $(kubectl -n kube-system get pod -l component=etcd --no-headers -o custom-columns=NAME:.metadata.name | head -1) – etcdctl --cert /var/lib/rancher/rke2/server/tls/etcd/server-client.crt --key /var/lib/rancher/rke2/server/tls/etcd/server-client.key --cacert /var/lib/rancher/rke2/server/tls/etcd/server-ca.crt defrag --cluster

exit 0
