
variable "name" {
  description = "Name of Bastion instance"
  type        = string
  default     = "bastion"
}
variable "firewall_rule_name" {
  description = "Firewall rule name for allowing SSH from IAP"
  type        = string
  default     = "allow-ssh-from-iap-to-tunnel"
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "service_account_email" {
  description = "Bastion service account"
  type        = string
  # Required
}

variable "network" {
  description = "Bastion network"
  type        = string
  # Required
}

variable "zone" {
  description = "Bastion network zone"
  type        = string
  # Required
}

variable "members" {
  description = "Bastion IAP users"
  type        = list(string)
  default     = []
}

variable "subnet" {
  description = "Bastion subnet"
  type        = string
  # Required
}

variable "image_family" {
  description = "Bastion image family"
  default     = "centos-8"
}

variable "machine_type" {
  description = "Bastion machine type"
  type        = string
  default     = "n1-standard-1"
}

variable "host_project" {
  description = "Network host project"
  type        = string
  # Required
}
