# Deploying the ip-masq-agent

IP masquerading is a form of source network address translation (SNAT) used to perform many-to-one IP address translations. GKE can use IP masquerading to change the source IP addresses of packets sent from Pods. When IP masquerading applies to a packet emitted by a Pod, GKE changes the packet's source address from the Pod IP to the underlying node's IP address. Masquerading a packet's source is useful when a recipient is configured to receive packets only from the cluster's node IP addresses.
(https://cloud.google.com/kubernetes-engine/docs/concepts/ip-masquerade-agent)

This feature is used for pods to reach on-premise environment.

Create a configmap after updating nonMasqueradeCIDRs with pod and node ip address ranges.

```shell
kubectl create configmap ip-masq-agent --namespace=kube-system --from-file=ip-masq-agent-config.yml
```

Create a daemonset.

```shell
kubectl apply -f ip-masq-agent-daemonset.yml
```


