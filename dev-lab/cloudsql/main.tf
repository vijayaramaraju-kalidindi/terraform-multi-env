data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../shared-network/terraform.tfstate"
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("../../key.json")
}

resource "google_project_service" "sql_api" {
  service = "sqladmin.googleapis.com"
}

resource "google_sql_database_instance" "mysql" {
  name             = "lab-mysql"
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = data.terraform_remote_state.network.outputs.vpc_self_link
    }

    backup_configuration {
      enabled = true
    }
  }

  deletion_protection = false

  depends_on = [google_project_service.sql_api]
}
