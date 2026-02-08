resource "google_storage_bucket" "app_bucket" {
  name     = "${var.project_id}-app-bucket"
  location = "US"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}
