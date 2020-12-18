# GKE cluster with Istio and Config Connector enabled

Clone repo and update the values as described is the Start Here section.
If error with the Terraform backend bucket, ensure BUCKET_NAME parameter  ```~/scripts/gcp.sh``` and bucket in ```~/gcp/terr-init.tf``` match. Delete the .terraform folder inside ~/gcp and run the script again.

When ready, a GKE cluster with auto-scaling enabled, Istio and Config Connector will be created. ArgoCD will bootstrap the cluster and deploy app.
Check K8s events and you storage browser. Config Connector will create a storage bucket. Check ~/app/gcp-cloud-services/templates/storageBucket.yml

Octant in read only mode, you can automate with Cloud Build.
Check Services in your GKE Dashboard on GCP subscription. Set SLO's and SLI's.

This is only for testing purposes.
To delete go to ~/gcp and run ```terraform destroy```
Delete the storage bucket(s) to avoid charges in your GCP subscription.
## Start Here

```git clone```

- Go to ```~/gcp/terr-init.tf``` and update the provider and backend blocks with your values

- Go to ```~/k8s/k8s-cluster-bootstrap/namespaces.yml``` and update with your project-id

- Go to ```~/k8s/k8s-cluster-bootstrap/values.yml``` and update with your google service account. Check the comments under the service account in values.yml

- Go to ```~/scripts/gcp.sh``` and update ```# Parameters``` with your values.

- To run from your laptop:  ```gcloud auth application-default login```

- From ~/scripts execute ```./gcp.sh```

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
