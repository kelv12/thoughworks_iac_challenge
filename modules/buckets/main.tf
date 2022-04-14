module "gcs_buckets" {
  source          = "terraform-google-modules/cloud-storage/google"
  version         = "3.0.0"
  project_id      = var.project_id
  prefix          = var.prefix
  set_admin_roles = var.set_admin_roles
  storage_admins  = var.storage_admins
  versioning      = var.versioning
  bucket_admins   = var.bucket_admins
  names           = var.names
  admins          = var.object_admins
  storage_class   = var.storage_class
  force_destroy   = var.force_destroy
  location        = var.location
}
