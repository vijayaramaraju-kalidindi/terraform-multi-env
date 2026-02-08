resource "google_sql_database_instance" "mysql" {
  name             = var.instance_name
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier = var.tier

    backup_configuration {
      enabled = true
    }
  }

  deletion_protection = false
}
