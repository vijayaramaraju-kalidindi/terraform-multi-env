provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("../../key.json")
}

resource "google_project_service" "redis_api" {
  service = "redis.googleapis.com"
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../shared-network/terraform.tfstate"
  }
}

resource "google_redis_instance" "redis" {
  name           = "lab-redis"
  tier           = "BASIC"
  memory_size_gb = 1
  region         = var.region

  authorized_network = data.terraform_remote_state.network.outputs.vpc_self_link

  depends_on = [google_project_service.redis_api]
}
