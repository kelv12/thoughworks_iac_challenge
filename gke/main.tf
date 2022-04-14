provider "google" {

  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_path)

}

locals {

  subnet = "projects/yassir-346913/regions/europe-west3/subnetworks/yassir-dev"

}

# GKE Service Account for Dev Project.
# module "gke_dev_project_sa" {
#   source         = "terraform-google-modules/service-accounts/google"
#   project_id  = var.project_id
#   prefix = "yassir"
#   names        = ["test"]
#   project_roles = [
#     "roles/logging.logWriter",
#     "roles/monitoring.metricWriter",
#     "roles/monitoring.viewer",
#     "roles/stackdriver.resourceMetadata.writer",
#     "roles/storage.objectViewer",
#     "roles/artifactregistry.reader"
#   ]
# }



module "bastion_host" {
  source                = "terraform-google-modules/bastion-host/google"
  name                  = "bastion-yassir"
  fw_name_allow_ssh_from_iap    = "allow-ssh-from-iap-to-tunnel"
  service_account_email = "my-test-sa@yassir-346913.iam.gserviceaccount.com"
  project               = var.project_id
  zone                  = var.zone
  network               = "yassir-net"
  subnet                = local.subnet
  members               = ["user:abel.yakubu@endocodelab.com"]

}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.project_id
  name                       = "yassir"
  network                    = "yassir-net"
  # network                    = data.terraform_remote_state.vpc_state.outputs.network_name
  # network_project_id         = data.terraform_remote_state.vpc_state.outputs.project_id
  region                      = var.region
  subnetwork                 = var.gke_subnet
  ip_range_pods              = var.gke_pods_range_name
  ip_range_services          = var.gke_services_range_name
  regional                   = true
  # master_authorized_networks = [{ cidr_block = "${module.bastion_host.bastion_ip}/32", display_name = "bastion_cidr" }]
  # service_account            = module.gke_dev_project_sa.sa_email
  master_ipv4_cidr_block     = "192.168.0.0/28"

  node_pools = [
    {
      name               = "yassir-node-pool"
      machine_type       = "e2-medium"
      node_locations     = "europe-west3-a"
      min_count          = 1
      max_count          = 2
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 2
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    yassir-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    yassir-node-pool = {
      yassir-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    yassir-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    yassir-node-pool = [
      {
        key    = "yassir-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    yassir-node-pool = [
      "yassir-node-pool",
    ]
  }
}

# resource "google_container_cluster" "public" {
#   # provider                 = google-beta

#   name                     = "yassir"
#   location                 = var.region

#   network                  = "yassir-net"
#   subnetwork               = var.gke_subnet

#   private_cluster_config {
#     enable_private_endpoint = false
#     enable_private_nodes    = true
#     master_ipv4_cidr_block     = "192.168.0.0/28"
#   }

#   # master_authorized_networks_config {
#   #   dynamic "cidr_blocks" {
#   #       for_each = var.authorized_source_ranges
#   #       content {
#   #           cidr_block = cidr_blocks.value
#   #       }
#   #   }
#   #  }

#   maintenance_policy {
#     recurring_window {
#       start_time = "2021-06-18T00:00:00Z"
#       end_time   = "2050-01-01T04:00:00Z"
#       recurrence = "FREQ=WEEKLY"
#     }
#   }

#   # Enable Autopilot for this cluster
#   enable_autopilot = true

#   # Configuration of cluster IP allocation for VPC-native clusters
#   ip_allocation_policy {
#     cluster_secondary_range_name  = "pods"
#     services_secondary_range_name = "services"
#   }

#   # Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters.
#   release_channel {
#     channel = "REGULAR"
#   }
# }


