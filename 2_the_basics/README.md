# 2. The Basics

In this section we're covering Kubernetes basics. This mostly based on the
[Kubernetes Basics
tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/) modules 2
through 6 thus it's recommended to go through the official tutorial.

## This

This directory contains a simple web app that we're going to deploy to the
Kubernetes cluster. It also comes with `lab.sh` script that encapsulates
various commands we're going to run.

## Build Web App image

We can build a web app image with `lab.sh build <version>`. We're use this
image throughout this lab session. Once the image is built we can push it to
the local registry to the push command.

```sh
$ ./lab.sh build v1
$ ./lab.sh push v1
```
