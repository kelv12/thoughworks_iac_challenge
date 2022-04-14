variable "versioning" {
  type        = map(bool)
  description = "Bucket Versioning - bucket-name => boolean"
  default     = {}
}
variable "project_id" {
  type        = string
  description = "A project to create a GCS bucket (bucket_name) in, useful for Terraform state (optional)"
  # Required
}
variable "storage_admins" {
  type        = list(string)
  description = "IAM-style members who will be granted roles/storage.objectAdmin on all buckets"
  default     = []
}
variable "set_admin_roles" {
  description = "Grant roles/storage.objectAdmin role to admins and bucket_admins, defaults to false"
  type        = bool
  default     = false
}
variable "bucket_admins" {
  type        = map(string)
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket admins"
  default     = {}
}
variable "names" {
  type        = list(string)
  description = "Bucket name suffixes"
  default     = []
}
variable "prefix" {
  type        = string
  description = "Prefix used to generate the bucket name, defaults to null"
  default     = ""
}
variable "object_admins" {
  type        = list(string)
  description = "IAM-style members who will be granted roles/storage.objectAdmin on all buckets"
  default     = []
}
variable "storage_class" {
  type        = string
  description = "Bucket storage class, defaults to STANDARD"
  default     = "STANDARD"
}
variable "location" {
  type        = string
  description = "Bucket location, defaults to EU"
  default     = "EU"
}

variable "force_destroy" {
  type        = map(bool)
  description = "Forcefully destroy a bucket, even if it is not empty. bucketname => boolean"
  default     = {}
}
