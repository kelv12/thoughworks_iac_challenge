################################################################################
# Generic variables
################################################################################
variable "project_id" {
  type        = string
  description = "A project to create a GKE cluster in"
}

variable "region" {
  type        = string
  description = "The region to host the cluster in"
  default     = "europe-west3"
}

variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in"
  default     = ["europe-west3-a", "europe-west3-b", "europe-west3-c"]
}

################################################################################
# GKE general vars
################################################################################
variable "name" {
  type        = string
  description = "A human readable name for the cluster"
}

variable "regional" {
  type        = bool
  description = "Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!)"
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region."
  default     = "latest"
}

variable "release_channel" {
  type        = string
  description = "(Beta) The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`."
  default     = "REGULAR"
}

variable "maintenance_start_time" {
  type        = string
  description = "Time window specified for daily maintenance operations in RFC3339 format"
  default     = "06:00"
}

variable "registry_project_ids" {
  type        = list(string)
  description = "Projects holding Google Container Registries. If empty, we use the cluster project. If a service account is created and the grant_registry_access variable is set to true, the storage.objectViewer and artifactregsitry.reader roles are assigned on these projects."
  default     = []
}

variable "config_connector" {
  type        = bool
  description = "(Beta) Whether ConfigConnector is enabled for this cluster."
  default     = false
}

variable "cluster_resource_labels" {
  type        = map(string)
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  default     = {}
}

//variable "resource_usage_export_dataset_id" {
//  type        = string
//  description = "The dataset id for which network egress metering for this cluster will be enabled. If enabled, a daemonset will be created in the cluster to meter network egress traffic."
//  default     = ""
//}

variable "sandbox_enabled" {
  type        = bool
  description = "(Beta) Enable GKE Sandbox (Do not forget to set `image_type` = `COS_CONTAINERD` to use it)."
  default     = false
}

//variable "notification_config_topic" {
//  type        = string
//  description = "The desired Pub/Sub topic to which notifications will be sent by GKE. Format is projects/{project}/topics/{topic}."
//  default     = ""
//}

################################################################################
# GKE nodepool vars
################################################################################



variable "node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pools"
}

variable "node_pools_tags" {
  type        = map(list(string))
  description = "Map of maps containing node tags by node-pool name"
}

variable "node_pools_labels" {
  type        = map(map(string))
  description = "Map of maps containing node labels by node-pool name"
}

variable "node_pools_metadata" {
  type        = map(map(string))
  description = "Map of maps containing node metadata by node-pool name"
}

variable "node_pools_taints" {
  type        = map(list(object({ key = string, value = string, effect = string })))
  description = "Map of lists containing node taints by node-pool name"
}

variable "node_pools_oauth_scopes" {
  type        = map(list(string))
  description = "Map of lists containing node oauth scopes by node-pool name"
}

variable "service_account" {
  type        = string
  description = "Service account to manage GKE cluster."
  default     = ""
}


variable "nodes_service_account" {
  type        = string
  description = "Use the given service account for nodes rather than creating a new dedicated service account."
  default     = ""
}

variable "enable_shielded_nodes" {
  type        = bool
  description = "Enable Shielded Nodes features on all nodes in this cluster"
  default     = true
}


variable "default_max_pods_per_node" {
  description = "The maximum number of pods to schedule per node"
  default     = 110
}

################################################################################
# Network vars
################################################################################
variable "network" {
  type        = string
  description = "The VPC network to host the cluster in"
}

variable "network_project_id" {
  type        = string
  description = "The project ID of the shared VPC's host (for shared vpc support)"
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to host the cluster in"
}

variable "ip_range_pods" {
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "ip_range_services" {
  type        = string
  description = "The _name_ of the secondary subnet range to use for services"
}

variable "master_authorized_networks" {
  type = list(object({
    cidr_block   = string,
    display_name = string
  }))
  description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
  default     = []
}

variable "http_load_balancing" {
  type        = bool
  description = "Enable httpload balancer addon. The addon allows whoever can create Ingress objects to expose an application to a public IP. Network policies or Gatekeeper policies should be used to verify that only authorized applications are exposed."
  default     = false
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network"
  default     = "10.0.0.0/28"
}


//variable "istio" {
//  description = "(Beta) Enable Istio addon"
//  default     = false
//}
//
//variable "istio_auth" {
//  type        = string
//  description = "(Beta) The authentication type between services in Istio."
//  default     = "AUTH_MUTUAL_TLS"
//}

#variable "authenticator_security_group" {
#  type        = string
#  description = "The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com"
#}


