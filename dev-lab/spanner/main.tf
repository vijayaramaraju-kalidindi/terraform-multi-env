terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}


provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("../../key.json")
}

resource "google_project_service" "spanner_api" {
  service = "spanner.googleapis.com"
}

resource "google_spanner_instance" "instance" {
  name         = var.instance_name
  config       = var.instance_config
  display_name = var.display_name
  num_nodes    = var.num_nodes
  
  depends_on = [google_project_service.spanner_api]
}

resource "google_spanner_database" "database" {
  instance = google_spanner_instance.instance.name
  name     = var.database_name
  deletion_protection = false
}


