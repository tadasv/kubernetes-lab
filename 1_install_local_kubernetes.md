# Install Kubernetes on your workstation

There are several different ways to install Kubernetes on your machine:
minikube, kind, a set of qemu VMs.

The simplest way to get started with Kubernetes locally is to use
[kind](https://kind.sigs.k8s.io/). Kind is my preferred option since this is
what is used to test Kubernetes by the k8s developers. It also lets you test
things out in "HA" mode by running multi-node control plane and worker nodes.

Follow kind installation instructions on their website. When it's time to
create a kind cluster it's preferred to use their [bootstrap
script](https://kind.sigs.k8s.io/docs/user/local-registry/) that adds support
for local docker registry. This run local docker registry in a separate
container that's accessible to the k8s cluster, drastically simplifying Docker
workflow.
