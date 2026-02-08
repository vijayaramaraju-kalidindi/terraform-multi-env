provider "google" {
  project = "nomadic-genre-486711-h6"
  #credentials = file("key.json")
  region  = "us-central1"
}

module "network" {
  source      = "../../modules/network"
  vpc_name    = "prod-vpc"
  subnet_name = "prod-subnet"
  cidr        = "10.20.0.0/24"
  region      = "us-central1"
}

module "compute" {
  source        = "../../modules/compute"
  vm_name       = "prod-vm"
  machine_type  = "e2-micro"
  zone          = "us-central1-a"
  subnet_id     = module.network.subnet_id
}

### Testing Branching