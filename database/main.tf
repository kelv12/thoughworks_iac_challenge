provider "google" {

  project     = var.project_id
  region      = var.gcp_region
  credentials = file(var.credentials_path)

}

locals {
  private_network = "https://www.googleapis.com/compute/v1/projects/yassir-346913/global/networks/yassir-net"
}

resource "google_compute_global_address" "cloud_sql_private_ip_address" {
  name          = "sql-private-ip"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = local.private_network
}

resource "google_service_networking_connection" "cloud_sql_private_vpc_connection" {
  network                 = local.private_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.cloud_sql_private_ip_address.name]
}

resource "google_sql_database_instance" "master" {
name = "instance-yassir"
database_version = "MYSQL_5_7"
region = var.gcp_region
deletion_protection     = false
depends_on = [google_service_networking_connection.cloud_sql_private_vpc_connection]
settings {
    tier = "db-n1-standard-1"
    ip_configuration {
      ipv4_enabled    = false
      private_network = local.private_network
    }
  }
}
resource "google_sql_database" "database" {
name = "yassir-db"
instance = "${google_sql_database_instance.master.name}"
}
resource "google_sql_user" "users" {
name = "root"
instance = "${google_sql_database_instance.master.name}"
password = "password"
}