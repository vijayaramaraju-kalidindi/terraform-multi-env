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
<<<<<<< Updated upstream
=======

resource "google_sql_database" "app_db" {
  name     = "app_database"
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "app_user" {
  name     = "appuser"
  instance = google_sql_database_instance.mysql.name
  password = "StrongPassword123!"
}
>>>>>>> Stashed changes
