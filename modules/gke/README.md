# GKE Module

## Todo
* Add workload identities
* Add nodepools

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | 17.3.0 |

## Resources

| Name | Type |
|------|------|
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_resource_labels"></a> [cluster\_resource\_labels](#input\_cluster\_resource\_labels) | The GCE resource labels (a map of key/value pairs) to be applied to the cluster | `map(string)` | `{}` | no |
| <a name="input_config_connector"></a> [config\_connector](#input\_config\_connector) | (Beta) Whether ConfigConnector is enabled for this cluster. | `bool` | `false` | no |
| <a name="input_default_max_pods_per_node"></a> [default\_max\_pods\_per\_node](#input\_default\_max\_pods\_per\_node) | The maximum number of pods to schedule per node | `number` | `110` | no |
| <a name="input_enable_shielded_nodes"></a> [enable\_shielded\_nodes](#input\_enable\_shielded\_nodes) | Enable Shielded Nodes features on all nodes in this cluster | `bool` | `true` | no |
| <a name="input_http_load_balancing"></a> [http\_load\_balancing](#input\_http\_load\_balancing) | Enable httpload balancer addon. The addon allows whoever can create Ingress objects to expose an application to a public IP. Network policies or Gatekeeper policies should be used to verify that only authorized applications are exposed. | `bool` | `false` | no |
| <a name="input_ip_range_pods"></a> [ip\_range\_pods](#input\_ip\_range\_pods) | The _name_ of the secondary subnet ip range to use for pods | `string` | n/a | yes |
| <a name="input_ip_range_services"></a> [ip\_range\_services](#input\_ip\_range\_services) | The _name_ of the secondary subnet range to use for services | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. | `string` | `"latest"` | no |
| <a name="input_maintenance_start_time"></a> [maintenance\_start\_time](#input\_maintenance\_start\_time) | Time window specified for daily maintenance operations in RFC3339 format | `string` | `"06:00"` | no |
| <a name="input_master_authorized_networks"></a> [master\_authorized\_networks](#input\_master\_authorized\_networks) | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | <pre>list(object({<br>    cidr_block   = string,<br>    display_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation to use for the hosted master network | `string` | `"10.0.0.0/28"` | no |
| <a name="input_name"></a> [name](#input\_name) | A human readable name for the cluster | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The VPC network to host the cluster in | `string` | n/a | yes |
| <a name="input_network_project_id"></a> [network\_project\_id](#input\_network\_project\_id) | The project ID of the shared VPC's host (for shared vpc support) | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | List of maps containing node pools | `list(map(string))` | n/a | yes |
| <a name="input_node_pools_labels"></a> [node\_pools\_labels](#input\_node\_pools\_labels) | Map of maps containing node labels by node-pool name | `map(map(string))` | n/a | yes |
| <a name="input_node_pools_metadata"></a> [node\_pools\_metadata](#input\_node\_pools\_metadata) | Map of maps containing node metadata by node-pool name | `map(map(string))` | n/a | yes |
| <a name="input_node_pools_oauth_scopes"></a> [node\_pools\_oauth\_scopes](#input\_node\_pools\_oauth\_scopes) | Map of lists containing node oauth scopes by node-pool name | `map(list(string))` | n/a | yes |
| <a name="input_node_pools_tags"></a> [node\_pools\_tags](#input\_node\_pools\_tags) | Map of maps containing node tags by node-pool name | `map(list(string))` | n/a | yes |
| <a name="input_node_pools_taints"></a> [node\_pools\_taints](#input\_node\_pools\_taints) | Map of lists containing node taints by node-pool name | `map(list(object({ key = string, value = string, effect = string })))` | n/a | yes |
| <a name="input_nodes_service_account"></a> [nodes\_service\_account](#input\_nodes\_service\_account) | Use the given service account for nodes rather than creating a new dedicated service account. | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | A project to create a GKE cluster in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | `"europe-west3"` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!) | `bool` | n/a | yes |
| <a name="input_registry_project_ids"></a> [registry\_project\_ids](#input\_registry\_project\_ids) | Projects holding Google Container Registries. If empty, we use the cluster project. If a service account is created and the grant\_registry\_access variable is set to true, the storage.objectViewer and artifactregsitry.reader roles are assigned on these projects. | `list(string)` | `[]` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | (Beta) The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`. | `string` | `"REGULAR"` | no |
| <a name="input_sandbox_enabled"></a> [sandbox\_enabled](#input\_sandbox\_enabled) | (Beta) Enable GKE Sandbox (Do not forget to set `image_type` = `COS_CONTAINERD` to use it). | `bool` | `false` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account to manage GKE cluster. | `string` | `""` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork to host the cluster in | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones to host the cluster in | `list(string)` | <pre>[<br>  "europe-west3-a",<br>  "europe-west3-b",<br>  "europe-west3-c"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_certificate"></a> [ca\_certificate](#output\_ca\_certificate) | Cluster ca certificate (base64 encoded) |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Cluster ID |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Cluster endpoint |
| <a name="output_horizontal_pod_autoscaling_enabled"></a> [horizontal\_pod\_autoscaling\_enabled](#output\_horizontal\_pod\_autoscaling\_enabled) | Whether horizontal pod autoscaling enabled |
| <a name="output_http_load_balancing_enabled"></a> [http\_load\_balancing\_enabled](#output\_http\_load\_balancing\_enabled) | Whether http load balancing enabled |
| <a name="output_identity_namespace"></a> [identity\_namespace](#output\_identity\_namespace) | Workload Identity namespace |
| <a name="output_location"></a> [location](#output\_location) | Cluster location (region if regional cluster, zone if zonal cluster) |
| <a name="output_logging_service"></a> [logging\_service](#output\_logging\_service) | Logging service used |
| <a name="output_master_authorized_networks_config"></a> [master\_authorized\_networks\_config](#output\_master\_authorized\_networks\_config) | Networks from which access to master is permitted |
| <a name="output_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#output\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation used for the hosted master network |
| <a name="output_master_version"></a> [master\_version](#output\_master\_version) | Current master kubernetes version |
| <a name="output_min_master_version"></a> [min\_master\_version](#output\_min\_master\_version) | Minimum master kubernetes version |
| <a name="output_monitoring_service"></a> [monitoring\_service](#output\_monitoring\_service) | Monitoring service used |
| <a name="output_name"></a> [name](#output\_name) | Cluster name |
| <a name="output_network_policy_enabled"></a> [network\_policy\_enabled](#output\_network\_policy\_enabled) | Whether network policy enabled |
| <a name="output_node_pools_names"></a> [node\_pools\_names](#output\_node\_pools\_names) | List of node pools names |
| <a name="output_node_pools_versions"></a> [node\_pools\_versions](#output\_node\_pools\_versions) | List of node pools versions |
| <a name="output_peering_name"></a> [peering\_name](#output\_peering\_name) | The name of the peering between this cluster and the Google owned VPC. |
| <a name="output_region"></a> [region](#output\_region) | Cluster region |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The service account to default running nodes as if not overridden in `node_pools`. |
| <a name="output_type"></a> [type](#output\_type) | Cluster type (regional / zonal) |
| <a name="output_zones"></a> [zones](#output\_zones) | List of zones in which the cluster resides |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
