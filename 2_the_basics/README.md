# 2. The Basics

In this section we're covering Kubernetes basics. This is mostly based on the
[Kubernetes Basics
tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/) modules 2
through 6 thus it's recommended to go through the official tutorial.

## This

This directory contains a simple web app that we're going to deploy to the
Kubernetes cluster. It also comes with `lab.sh` script that encapsulates
various commands we're going to run.

## Build Web App image

We can build a web app image with `lab.sh build <version>`. We are going to use
this image throughout this lab session. Once the image is built we can push it
to the local registry to the push command.

```sh
$ ./lab.sh build v1
$ ./lab.sh push v1
```

## Service configuration

Service is configured via `app.yaml` file. It can be deployed with `apply`
command and removed with `delete` command.

## How this works

[Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
manages [pods](https://kubernetes.io/docs/concepts/workloads/pods/) and
[replicasets](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/).
It provides functionally for scaling, rolling out and rolling back pods and
replicasets. When deployment configuration is applied PodSpec configuration is
hashed and the hash is stored as label as part of the pod metadata. This
auto-hashing mechanism is what controls when new replicasets get created vs
when they get updated (e.g. during scale up/down)

TODO [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
