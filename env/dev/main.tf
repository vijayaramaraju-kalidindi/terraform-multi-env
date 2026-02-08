terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  credentials = file("key.json")
  region  = "us-central1"
}

resource "google_project_service" "service_networking" {
  service = "servicenetworking.googleapis.com"
}


module "network" {
  source      = "../../modules/network"
  vpc_name    = "dev-vpc"
  subnet_name = "dev-subnet"
  cidr        = "10.10.0.0/24"
  region      = "us-central1"
}

module "compute" {
  source        = "../../modules/compute"
  vm_name       = "dev-vm"
  machine_type  = "f1-micro"
  zone          = "us-central1-a"
  subnet_id     = module.network.subnet_id
}

module "storage" {
  source     = "../../modules/storage"
  project_id = var.project_id
}

resource "google_project_service" "sql_api" {
  service = "sqladmin.googleapis.com"
}
module "cloudsql" {
  source        = "../../modules/cloudsql"
  instance_name = "dev-mysql"
  region        = var.region
  tier          = "db-f1-micro"

  depends_on = [google_project_service.sql_api]
}
