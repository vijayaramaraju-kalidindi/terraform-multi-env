variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "us-central1"
}

variable "instance_name" {
  description = "Spanner instance name"
  type        = string
}

variable "display_name" {
  description = "Spanner display name"
  type        = string
}

variable "instance_config" {
  description = "Spanner instance configuration"
  type        = string
  default     = "regional-us-central1"
}

variable "num_nodes" {
  description = "Number of Spanner nodes"
  type        = number
  default     = 1
}

variable "database_name" {
  description = "Spanner database name"
  type        = string
}
