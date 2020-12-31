# GKE sample application with ArgoCD

- Status: Ready to deploy

GitOps project, based on ArgoCD.
App of apps deployment style.
The project enables **Config Connector for managing Google Cloud resources through Kubernetes.**

<https://cloud.google.com/config-connector/docs/overview>

Check **app/gcp-cloud-services/templates** for storage config with Config Connector

Use as reference or for testing purposes.

## GKE cluster

- ArgoCD

- Cert-Manager

- Kube-Monkey

- Read only Octant in a Docker container

## Project

1) services: sock shop by Weaveworks. Every service is a Helm Chart.

2) scripts: ./gcp.sh will build the environment

3) k8s: argo_config, k8s-charts and k8s-cluster-bootstrap

4) gcp: Terraform’s manifests for GKE

5) build: octant in a docker container with k8s manifests.

6) app: argo_config, eshop and  gcp-cloud-services
