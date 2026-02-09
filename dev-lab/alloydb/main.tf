provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("../../key.json")
}

resource "google_project_service" "alloydb_api" {
  service = "alloydb.googleapis.com"
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../shared-network/terraform.tfstate"
  }
}

resource "google_alloydb_cluster" "cluster" {
  cluster_id = var.cluster_id
  location   = var.region
  deletion_protection = false
 network_config {
  network = data.terraform_remote_state.network.outputs.vpc_id
 }
  initial_user {
    user     = var.db_user
    password = var.db_password
  }

  depends_on = [google_project_service.alloydb_api]
}

resource "google_alloydb_instance" "primary" {
  cluster       = google_alloydb_cluster.cluster.name
  instance_id   = var.instance_id
  instance_type = "PRIMARY"
  

  machine_config {
    cpu_count = var.cpu_count
  }
}