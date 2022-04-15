provider "google" {

  project     = var.project_id
  region      = var.gcp_region
  credentials = file(var.credentials_path)

}

module "vpc" {
  source                                 = "terraform-google-modules/network/google"
  version                                = "3.3.0"

  project_id = var.project_id
  network_name   = "yassir-net"
  routing_mode                           = "GLOBAL"

  # additional_routes = []
  subnets = [
    {
      subnet_name   = "yassir-dev"
      subnet_ip     = "10.48.10.0/24"
      subnet_region = var.gcp_region

      # Enables access to the project's private Google API's from the subnet
      subnet_private_access = true

      # Enables traffic flow logs
      subnet_flow_logs = false
    },
    {
      subnet_name   = "yassir-prod"
      subnet_ip     = "10.48.11.0/24"
      subnet_region = var.gcp_region

      # Enables access to the project's private Google API's from the subnet
      subnet_private_access = true

      # Enables traffic flow logs
      subnet_flow_logs = false
    }
  ]

  secondary_ranges = {
    yassir-dev = [
      {
        range_name    = "gke-pods-dev"
        ip_cidr_range = "10.1.0.0/16"
      },
      {
        range_name    = "gke-services-dev"
        ip_cidr_range = "10.2.0.0/16"
      }
    ]
    yassir-prod = [
      {
        range_name    = "gke-pods-prod"
        ip_cidr_range = "10.3.0.0/16"
      },
      {
        range_name    = "gke-services-prod"
        ip_cidr_range = "10.4.0.0/16"
      }
    ]
  }
}
