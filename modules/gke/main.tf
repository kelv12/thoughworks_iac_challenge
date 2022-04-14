# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  # source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster-update-variant"
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "17.3.0"

  # add_cluster_firewall_rules = true
  # firewall_inbound_ports     = ["9443", "15017"]

  project_id = var.project_id
  name       = var.name
  region     = var.region
  regional   = var.regional
  zones      = var.zones

  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  network                    = var.network
  network_project_id         = var.network_project_id
  subnetwork                 = var.subnetwork
  master_authorized_networks = var.master_authorized_networks
  http_load_balancing        = var.http_load_balancing

  # We suggest the use coarse network policies to enforce restrictions in the
  # communication between pods.
  #
  # NOTE: Enabling network policy is not sufficient to enforce restrictions.
  # NetworkPolicies need to be configured in every namespace. The network
  # policies should be under the control of a central cluster management team,
  # rather than individual teams.
  network_policy = false

  # kubernetes_version = var.kubernetes_version
  # Nodes are created with a default version. The nodepool enables
  # auto_upgrade so that the node versions can be kept up to date with
  # the master upgrades.
  #
  # https://cloud.google.com/kubernetes-engine/versioning-and-upgrades
  # release_channel = var.release_channel

  # maintenance_start_time = var.maintenance_start_time

  # We suggest removing the default node pull, as it cannot be modified without
  # destroying the cluster.
  remove_default_node_pool = true
  # initial_node_count       = 2

  node_pools = var.node_pools
  # node_pools_labels = var.node_pools_labels
  # # TODO: take care of this later
  node_pools_metadata = var.node_pools_metadata
  node_pools_taints   = var.node_pools_taints
  node_pools_tags     = var.node_pools_tags

  # TODO: take care of this later
  node_pools_oauth_scopes = var.node_pools_oauth_scopes

  # We never use the default service account for the cluster. The default
  # project/editor permissions can create problems if nodes were to be ever
  # compromised.
  # We either:
  # - Create a dedicated service account with minimal permissions to run nodes.
  #   All applications should run with an identity defined via Workload Identity anyway.
  # - Use a service account passed as a parameter to the module, in case the user
  #   wants to maintain control of their service accounts.
  # TODO: Does it make sense to use a custom service account? Or should we rather just use the one by default
  create_service_account = false
  service_account        = var.service_account

  # Lets set this to true for now
  # Needs to be changed if we want to use a global registry
  # grant_registry_access = true
  # registry_project_ids  = var.registry_project_ids

  # Basic Auth disabled
  # basic_auth_username = ""
  # basic_auth_password = ""

  # issue_client_certificate = false

  # cluster_resource_labels = var.cluster_resource_labels

  # We enable private endpoints to limit exposure.
  # Use the masters private IP as API endpoint
  # TODO: check what this does
  enable_private_endpoint = true
  # Connect to that private endpoint
  # TODO: check what this does
  # deploy_using_private_endpoint = true

  # Private nodes better control public exposure, and reduce
  # the ability of nodes to reach to the Internet without
  # additional configurations.
  enable_private_nodes = true

  # Whether the cluster master is accessible globally (from any region)
  # or only within the same region as the private endpoint.
  # master_global_access_enabled = true

  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  # Istio can be enabled but is set to false by default
  # We don't want to run istio in the beginning,
  # but is is nevertheless good to have an option to do so
  # istio      = var.istio
  # istio_auth = var.istio_auth

  # Lets disable cloudrun addon for now to keep things simple
  # setting this to false is not explicitly needed
  # but lets keep it there as a reminder it exists
  # cloudrun = false

  # Lets use the managed DNS Node cache
  # If we see it does not work for us, we can always use our current solution
  # dns_cache = true

  # Whether config connector is enabled for this cluster
  # We make this configurable but deactivated
  # Once we decide how to proceed we can hardcode this
  # config_connector = var.config_connector

  # is set to 110 by default
  # default_max_pods_per_node = var.default_max_pods_per_node

  # TODO: there is another parameter needed to actually use this
  # resource_usage_export_dataset_id = var.resource_usage_export_dataset_id

  # Sandbox is needed if the cluster is going to run any untrusted workload (e.g., user submitted code).
  # Sandbox can also provide increased protection in other cases, at some performance cost.
  # sandbox_enabled = var.sandbox_enabled

  # enable_vertical_pod_autoscaling = true

  # We enable identity namespace by default
  identity_namespace = "${var.project_id}.svc.id.goog"

  # TODO: Create a IAM group and pass this here
  # authenticator_security_group = var.authenticator_security_group

  enable_shielded_nodes = var.enable_shielded_nodes

  # gce_pd_csi_driver = true

  # notification_config_topic = var.notification_config_topic
  # configure_ip_masq = true
}

# TODO: We need to add this permission to the nodes_service_account
# Additionally, if service_account is set to create and grant_registry_access
# is requested, the service account requires the following role on the
# registry_project_ids projects:
# roles/resourcemanager.projectIamAdmin
