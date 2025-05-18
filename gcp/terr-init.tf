#*------------------------------------------------
#*   Terraform --Provider --Backend    
#*------------------------------------------------

provider "google" {
  project = "ptuddn-2025"
  region  = "europe-west2"
}

terraform {
  backend "gcs" {
    bucket = "ptuddn-2025-tfstate-01"
    prefix = "terraform/state"
  }
}
