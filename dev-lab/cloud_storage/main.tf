provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_path)
}

resource "google_project_service" "storage_api" {
  service = "storage.googleapis.com"
}

resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.bucket_location

  uniform_bucket_level_access = true

  versioning {
    enabled = var.enable_versioning
  }

  lifecycle_rule {
    condition {
      age = var.lifecycle_delete_days
    }
    action {
      type = "Delete"
    }
  }

  depends_on = [google_project_service.storage_api]
}
