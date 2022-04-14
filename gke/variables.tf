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
variable "region" {
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

# variable "members" {
#   description = "bastion host members"
#   type        = string
# }

# variable "bastion_zone" {
#   description = "Bastion zone"
#   type        = string
#   # Required
# }

variable "gke_subnet" {
  description = "Subnet to run GKE"
  type        = string
}

variable "gke_pods_range_name" {
  description = "Subnet to run GKE pods"
  type        = string
}

variable "gke_services_range_name" {
  description = "Subnet to run GKE services"
  type        = string
}

variable "knamespace" {
  description = "Kubernetes Namespace"
  type        = string
}

variable "ksa" {
  description = "Kubernetes service account"
  type        = string
}
