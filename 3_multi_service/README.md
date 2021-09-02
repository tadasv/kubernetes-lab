# 2. Multiple service and service discovery

Kubernetes has built-in service discovery. We illustrate this by launching two
web services:

1. k8s-lab-timeapp -- returns current time via http.
2. k8s-lab-remotefech -- makes an http request to timeapp and returns the response.

To make this work we need to make sure that deployments are exposed with
`Service`. Once that's done we can reference services via internal dns using
this template:

```
<service-name>.<namespace>.svc.cluster.local:<service port>
```

We can make a call to see this working:

```
tadas@fractal:3_multi_service$ kubectl get services
NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
k8s-lab-remotefetch   NodePort    10.96.98.221    <none>        8000:32400/TCP   13m
k8s-lab-timeapp       NodePort    10.96.76.50     <none>        8000:32004/TCP   13m
k8s-lab-webapp        NodePort    10.96.196.128   <none>        8000:30794/TCP   3d
kubernetes            ClusterIP   10.96.0.1       <none>        443/TCP          3d
tadas@fractal:3_multi_service$ curl $(./lab.sh cluster_ip):32400
response from remote service: Current time: 2021-09-02 12:55:07.28839101 +0000 UTC m=+839.431593603
```
