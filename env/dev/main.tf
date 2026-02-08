terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = "nomadic-genre-486711-h6"
  region  = "us-central1"
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
