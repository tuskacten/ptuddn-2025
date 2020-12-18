#*------------------------------------------------
#*   Google Cloud Platform --Enable API
#*------------------------------------------------

resource "google_project_service" "gke" {
  service = "container.googleapis.com"
}

resource "google_project_service" "crm" {
  service = "cloudresourcemanager.googleapis.com"
}
