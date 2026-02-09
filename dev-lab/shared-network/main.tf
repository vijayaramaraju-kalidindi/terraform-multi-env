provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("../../key.json")
}

resource "google_project_service" "service_networking" {
  service = "servicenetworking.googleapis.com"
}

module "network" {
  source      = "../../modules/network"
  vpc_name    = "lab-vpc"
  subnet_name = "lab-subnet"
  cidr        = "10.50.0.0/24"
  region      = var.region
}

resource "google_compute_global_address" "private_service_range" {
  name          = "lab-private-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.network.vpc_self_link
}

resource "google_service_networking_connection" "private_connection" {
  network                 = module.network.vpc_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private_service_range.name
  ]

  depends_on = [google_project_service.service_networking]
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
