#!/usr/bin/env bash

GREEN='\033[0;32m'
NC='\033[0m'

#? BUCKET_NAME must be unique across GCP
#? To run from your laptop:  gcloud auth application-default login

# Parameters
PROJECT_ID=gke-k8-cluster #FIXME Update the value if new project
ZONE=europe-west2-b
BUCKET_NAME=gcp-bucket-terr-011 #FIXME Update the value if new project
BUCKET_LOCATION=europe-west2

cat <<EOF
#*------------------------------------------------
#*   GCP --Create Terraform's backend --Enable API
#*------------------------------------------------
EOF
gcloud services enable storage.googleapis.com

echo
gsutil mb -p $PROJECT_ID -l $BUCKET_LOCATION -b on gs://$BUCKET_NAME

gsutil versioning set on gs://$BUCKET_NAME

gcloud services enable compute.googleapis.com
echo

cat <<EOF
#*------------------------------------------------
#*   Terraform --Init & Apply
#*------------------------------------------------
EOF

echo
cd ../gcp && terraform init && terraform apply --auto-approve
echo

cat <<EOF
#*------------------------------------------------
#*   GCP --Get K8s credentials
#*------------------------------------------------
EOF

echo
gcloud container clusters get-credentials dev-k8s --zone $ZONE --project $PROJECT_ID

echo

cat <<EOF
#*------------------------------------------------
#*   ArgoCD --Install
#*------------------------------------------------
EOF

echo
source ../scripts/./argocd_install.sh
echo

cat <<EOF
#*------------------------------------------------
#*   ArgoCD --Deploy K8s bootstrap app
#*------------------------------------------------
EOF

echo
cd ../k8s && kubectl apply -f argo_config/k8s-project.yml && kubectl apply -f argo_config/k8s-app.yml
echo
cd ../app && kubectl apply -f argo_config/eshop-project.yml && kubectl apply -f argo_config/eshop-app.yml

echo
echo -e "${LBLUE}--> Access Octant web ui:${NC}${GREEN} kubectl port-forward svc/octant -n octant 8000:8000 ${NC}--> in:${NC}${GREEN} localhost:8000${NC}\n"
echo

echo -e "${LBLUE}--> Access Shock Shop web :${NC}${GREEN} kubectl port-forward svc/front-end -n eshop-staging 8088:80 ${NC}--> in:${NC}${GREEN} localhost:8088${NC}\n"
