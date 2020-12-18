#*------------------------------------------------
#*   Terraform --Provider --Backend    
#*------------------------------------------------

provider "google" {
  project = "development-298310" #FIXME Update the value if new project
  region  = "europe-west2"
}

terraform {
  backend "gcs" {
    bucket = "gcp-bucket-terr-01" #FIXME Update the value if new project
    prefix = "terraform/state"
  }
}
