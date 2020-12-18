#!/usr/bin/env bash

PROJECT_ID=gke-k8-cluster
BUCKET_NAME=gcp-backend-01
BUCKET_LOCATION=europe-west2

# Create Terraform backend storage bucket
gsutil mb -p $PROJECT_ID -l $BUCKET_LOCATION -b on gs://$BUCKET_NAME

gsutil versioning set on gs://$BUCKET_NAME

## Get a list of GCP API's
## gcloud services list --available

# Enable Compute Engine API
gcloud services enable compute.googleapis.com

# Enable Secret Manager API
gcloud services enable secretmanager.googleapis.com

# For automation create Service Account and Secret Manager.
# To run from your laptop:  gcloud auth application-default login
