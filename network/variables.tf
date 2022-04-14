variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type = string
}

variable "organization_id" {
  description = "The organization id for the associated services"
  type = string
}

variable "credentials_path" {
  description = "Path to a service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fall back to Application Default Credentials."
  type = string
}
variable "gcp_region" {
  description = "GCP Region"
  type        = string
}

variable "zone" {
  description = "zone withing the region"
  type        = string
}

variable "project_id" {
  type        = string
  description = "Project id"
}