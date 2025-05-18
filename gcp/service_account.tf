#*------------------------------------------------------------------------------------------------
#*   Config Connector --Create Service Account --Give IAM SA elevated permissions
#*                    --Create an IAM policy binding SA/predefined Kubernetes SA
#*------------------------------------------------------------------------------------------------

data "google_project" "project" {}

resource "google_service_account" "config_connector" {
  account_id   = "k8s-service-account"
  display_name = "k8s-service-account"
}

resource "google_project_iam_member" "config_connector" {
  project = data.google_project.project.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.config_connector.account_id}@${data.google_project.project.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "config_connector_storage" {
  project = data.google_project.project.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.config_connector.account_id}@${data.google_project.project.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "config_connector_editor" {
  project = data.google_project.project.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.config_connector.account_id}@${data.google_project.project.project_id}.iam.gserviceaccount.com"
}

resource "google_service_account_iam_member" "config_connector" {
  service_account_id = google_service_account.config_connector.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${data.google_project.project.project_id}.svc.id.goog[cnrm-system/cnrm-controller-manager]"
  
  # Đảm bảo resource này được tạo sau khi cluster GKE đã được tạo hoàn toàn
  depends_on = [google_container_cluster.dev]
}
