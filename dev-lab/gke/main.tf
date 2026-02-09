provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("../../key.json")
}

resource "google_project_service" "gke_api" {
  service = "container.googleapis.com"
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../shared-network/terraform.tfstate"
  }
}


resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.region
  deletion_protection = false
  network    = data.terraform_remote_state.network.outputs.vpc_id
  subnetwork = data.terraform_remote_state.network.outputs.subnet_id
  remove_default_node_pool = true
  initial_node_count       = 1

  # Add this block to bypass SSD quota during initial creation
  node_config {
    disk_type    = "pd-standard"
    disk_size_gb = 20 
  }

  depends_on = [google_project_service.gke_api]
}
resource "google_container_node_pool" "primary_nodes" {
  name     = var.node_pool_name
  cluster  = google_container_cluster.cluster.name
  location = var.region

  node_count = var.node_count

  node_config {
    machine_type = var.machine_type

    disk_size_gb = 20
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}