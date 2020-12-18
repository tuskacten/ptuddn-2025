#*------------------------------------------------
#*   Terraform --Provider --Backend    
#*------------------------------------------------

provider "google" {
  project = "gke-k8-cluster" #FIXME Update the value if new project
  region  = "europe-west2"
}

terraform {
  backend "gcs" {
    bucket = "gcp-bucket-terr-011" #FIXME Update the value if new project
    prefix = "terraform/state"
  }
}
