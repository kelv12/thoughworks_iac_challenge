variable "gcp_region" {
  description = "GCP Region"
  type        = string
  # Required
}
variable "host_project_id" {
  description = "To create SQL instances in that parent project Id"
  type        = string
  # Required
}
variable "database_version" {
  description = "Version of the database. e.g MYSQL_5_7, POSTGRES_9_6"
  type        = string
  # Required
}
variable "instance_zone" {
  description = "Preferred zone for the master instance (e.g. 'europe-west3-a'). If null, Google will auto-assign a zone."
  type        = string
  default     = "europe-west3-a"
}
variable "instance_name" {
  description = "The name of Cloud SQL Instance"
  type        = string
  # Required
}
variable "master_tier" {
  description = "The tier for the master instance."
  type        = string
  # Required
}
variable "master_disk_type" {
  description = "The disk type for the master instance."
  type        = string
  default     = "PD_SSD"
}
variable "disk_size" {
  description = "Disk size for master Sql instance in GBs"
  type        = number
  # Required
}
variable "disk_autoresize" {
  description = "Configuration to increase storage size, defaults to true"
  type        = bool
  # Required
}
variable "create_random_instance_suffix" {
  description = "Sets random suffix at the end of the Cloud SQL resource name"
  type        = bool
  default     = true
}
variable "availability_type" {
  description = "The availability type for the master instance. Can be either REGIONAL (High Available) or ZONAL (Single Zone). REGIONAL enables automatic backup, point in time recovery and auto storage increase"
  type        = string
  default     = "REGIONAL"
}
variable "maintenance_window_day" {
  description = "The day of week (1-7) for the master instance maintenance. (e.g 1-Monday -> 7-Sunday)"
  type        = number
  default     = 3 # Wednesday
}
variable "maintenance_window_hour" {
  description = "The hour of day (0-23) maintenance window for the master instance maintenance."
  type        = number
  default     = 6 # 6:00 AM
}
variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance. Can be either canary or stable. Defaults to Canary"
  type        = string
  default     = "stable"
}
variable "labels" {
  description = "A map of custom labels to apply to the instance."
  type        = map(string)
  default     = {}
}
# Resources are created sequentially. Therefore we increase the default timeouts considerably to not have the operations time out.
variable "create_resource_timeout" {
  description = "The optional timout for instance creation that is applied to limit long database updates. Valid units of time are s, m, h."
  type        = string
  default     = "15m"
}
variable "update_resource_timeout" {
  description = "The optional timout for updating instance that is applied to limit long database updates. Valid units of time are s, m, h."
  type        = string
  default     = "15m"
}
variable "delete_resource_timeout" {
  description = "The optional timout for deletion of instance that is applied to limit long database updates. Valid units of time are s, m, h."
  type        = string
  default     = "20m"
}
variable "enable_public_internet_access" {
  description = "Enable IPv4 access. Only enable if you want your database open to internet"
  type        = bool
  default     = false
}

variable "authorized_networks" {
  description = "List of networks which are authorized to access SQL instance. Name (optional), Value is a CIDR notation IPv4 address that is allowed to access this SQL instance. "
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "require_ssl" {
  description = "Whether SSL connections over IP are enforced or not. Defaults to true"
  type        = bool
  default     = true
}
variable "private_network" {
  description = "(Optional) The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP. At least ipv4_enabled (enable_public_internet_access) must be enabled or a private_network must be configured. This setting can be updated, but it cannot be removed after it is set."
  type        = string
  default     = null
}
variable "deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance"
  type        = bool
  # Required
}
variable "database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server. See more details here -> https://cloud.google.com/sql/docs/mysql/flags"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
# BACKUP CONFIG VARIABLES
variable "backup_start_time" {
  description = "Backup time window - start time + 4 hours is the window in which SQL automated backups will be taken."
  type        = string
}
variable "days_of_trans_logs_retained" {
  description = ""
  type        = number
}
variable "days_of_backups_retained" {
  description = ""
  type        = number
}

# READ REPLICAS VARIABLES
variable "read_replica_name_suffix" {
  description = "Optional suffix to add to instance name"
  type        = string
  default     = ""
}
variable "read_replica_deletion_protection" {
  description = "Used to block Terraform from deleting replica SQL Instances."
  type        = bool
  default     = false
}
variable "read_replicas" {
  description = "List of read replicas to create. Replicas can be created on different zones, if different regions is required then encryption key is required."
  type = list(object({
    name            = string
    tier            = string
    zone            = string
    disk_type       = string
    disk_autoresize = bool
    disk_size       = string
    user_labels     = map(string)
    database_flags = list(object({
      name  = string
      value = string
    }))
    ip_configuration = object({
      authorized_networks = list(map(string))
      ipv4_enabled        = bool
      private_network     = string
      require_ssl         = bool
    })
    encryption_key_name = string
  }))
  default = []
}
