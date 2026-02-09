variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "BigQuery dataset location"
  type        = string
  default     = "US"
}

variable "dataset_id" {
  description = "BigQuery dataset ID"
  type        = string
}
