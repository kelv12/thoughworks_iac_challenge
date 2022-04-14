module "mysql" {
  source                           = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version                          = "8.0.0"
  region                           = var.gcp_region
  project_id                       = var.host_project_id
  database_version                 = var.database_version
  zone                             = var.instance_zone
  name                             = var.instance_name
  tier                             = var.master_tier
  disk_type                        = var.master_disk_type
  disk_size                        = var.disk_size
  disk_autoresize                  = var.disk_autoresize
  random_instance_name             = var.create_random_instance_suffix # e.g instanceName + randomsuffix
  availability_type                = var.availability_type
  maintenance_window_day           = var.maintenance_window_day
  maintenance_window_hour          = var.maintenance_window_hour
  maintenance_window_update_track  = var.maintenance_window_update_track
  enable_default_db                = false # Because we will create DBs in resource layer
  enable_default_user              = false # Because we will create Users in resource layer
  deletion_protection              = var.deletion_protection
  database_flags                   = var.database_flags
  read_replica_name_suffix         = var.read_replica_name_suffix
  read_replica_deletion_protection = var.read_replica_deletion_protection
  read_replicas                    = var.read_replicas
  ip_configuration = {
    authorized_networks = var.authorized_networks
    ipv4_enabled        = var.enable_public_internet_access
    private_network     = var.private_network
    require_ssl         = var.require_ssl
  }
  # By default, whenever module is called and SQL instance is created, backup should be enabled by default with few params that can be defined like backup_start_time, days_of_trans_logs_retained, days_of_backups_retained 
  backup_configuration = {
    enabled                        = true
    binary_log_enabled             = true # Only for MySQL
    start_time                     = var.backup_start_time
    location                       = null # If null, by default is Multi Regional
    transaction_log_retention_days = var.days_of_trans_logs_retained
    retained_backups               = var.days_of_backups_retained
    retention_unit                 = "COUNT"
  }
  create_timeout = var.create_resource_timeout
  update_timeout = var.update_resource_timeout
  delete_timeout = var.delete_resource_timeout
  user_labels    = var.labels
}
