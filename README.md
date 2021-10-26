# K3S (Kubernetes) Cluster backed by Flux

The purpose of this repo is to maintain a declarative kubernetes cluster where the git repo drives the state.  The important technologies are [k3s](https://k3s.io/) backed by [Flux](https://toolkit.fluxcd.io/) and [SOPS](https://toolkit.fluxcd.io/guides/mozilla-sops/).

I am also bootstrapping the cluster in [Proxmox](https://www.proxmox.com/en/) with [Terraform](https://www.terraform.io/).  Provisioning of the K3S stack is done using this [Ansible Role](https://github.com/PyratLabs/ansible-role-k3s).

A lot of credit needs to go to the [K8s@Home](https://k8s-at-home.com/) project for their template cluster.