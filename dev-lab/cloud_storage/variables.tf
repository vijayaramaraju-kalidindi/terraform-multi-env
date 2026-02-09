variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "us-central1"
}

variable "credentials_path" {
  description = "Path to service account key file"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique bucket name"
  type        = string
}

variable "bucket_location" {
  description = "Bucket location (US, EU, asia-south1 etc)"
  type        = string
  default     = "US"
}

variable "enable_versioning" {
  description = "Enable object versioning"
  type        = bool
  default     = true
}

variable "lifecycle_delete_days" {
  description = "Delete objects older than X days"
  type        = number
  default     = 30
}
