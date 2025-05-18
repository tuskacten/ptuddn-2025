#*------------------------------------------------
#*   Google Kubernetes Engine --Create Cluster
#*------------------------------------------------

resource "google_container_cluster" "dev" {
  name     = "dev-k8s"
  location = "europe-west2-b"
  project  = data.google_project.project.project_id

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  cluster_autoscaling {
    enabled = true

    resource_limits {
      resource_type = "cpu"
      minimum       = 2
      maximum       = 20
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 4
      maximum       = 60
    }
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }

  # VPC-native clusters route traffic between pods using a VPC network, and are able to route to other VPCs across network peerings along with several other benefits.
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
  provider = google-beta
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    istio_config {
      disabled = false
    }
    config_connector_config {
      enabled = true
    }

  }

}

#*------------------------------------------------
#*   Google Kubernetes Engine --Create Node Pool
#*------------------------------------------------
resource "google_container_node_pool" "primary_nodes" {
  name               = "dev-k8s-main-np"
  location           = "europe-west2-b"
  cluster            = google_container_cluster.dev.name
  initial_node_count = 1

  node_locations = [
    "europe-west2-b",
  ]


  autoscaling {
    min_node_count = "1"
    max_node_count = "3"
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    disk_type    = "pd-standard"
    disk_size_gb = 50

    metadata = {
      disable-legacy-endpoints = "true"
      workload-metadata        = "GKE_METADATA"
    }


    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

}
