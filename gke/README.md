# Dev Project

## Usage
---
1. Copy terraform.tfvars-example to terraform.tfvars:
    ```
    $ cp terraform.tfvars-example terraform.tfvars
    ```

2. Update terraform.tfvars file with values from your environment.

    1. Update the value of remote_state_proj_state_bucket with the bucket name that you defined earlier for projects.
        ```
        remote_state_proj_state_bucket = "p7s1-projects-<your-name>"
        ```

3. Copy remotestate.tf-example in projects/org-sharedvpc.
   ```
    $ cp remotestate.tf-example remotestate.tf
   ```
4. Update remotestate.tf file with values from your environment. This is the bucket which was created in the step (/projects/serviceprojects) (the dev one)

5. Initialize terraform (download modules):
    ```
    terraform init
    ```

6. Create an execution plan:
    ```
    terraform plan
    ```
7.  Apply the changes required to reach the desired state of the configuration:
    ```
    terraform apply
    ```
## Authentication
Service Account Impersonation -> Output of remote state of project_state Infra Dev service account

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | = 3.90.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.90.1 |
| <a name="provider_google.tokengen"></a> [google.tokengen](#provider\_google.tokengen) | 3.90.1 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion_host"></a> [bastion\_host](#module\_bastion\_host) | ../../modules/bastion_host | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | ../../modules/gke | n/a |
| <a name="module_gke_dev_project_sa"></a> [gke\_dev\_project\_sa](#module\_gke\_dev\_project\_sa) | ../../modules/service_account | n/a |
| <a name="module_sql_dev_project_sa"></a> [sql\_dev\_project\_sa](#module\_sql\_dev\_project\_sa) | ../../modules/service_account | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account_iam_member.gke_sa_iam_binding_dev](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.sql_sa_ksa_member](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/service_account_iam_member) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/data-sources/client_config) | data source |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/data-sources/project) | data source |
| [google_service_account_access_token.sa](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/data-sources/service_account_access_token) | data source |
| [terraform_remote_state.org_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.proj_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_zone"></a> [bastion\_zone](#input\_bastion\_zone) | Bastion zone | `string` | n/a | yes |
| <a name="input_dev_project_infra_team"></a> [dev\_project\_infra\_team](#input\_dev\_project\_infra\_team) | Dev Project infra team | `list(string)` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | GCP Region | `string` | n/a | yes |
| <a name="input_gke_pods_range_name"></a> [gke\_pods\_range\_name](#input\_gke\_pods\_range\_name) | Subnet to run GKE pods | `string` | n/a | yes |
| <a name="input_gke_services_range_name"></a> [gke\_services\_range\_name](#input\_gke\_services\_range\_name) | Subnet to run GKE services | `string` | n/a | yes |
| <a name="input_gke_subnet"></a> [gke\_subnet](#input\_gke\_subnet) | Subnet to run GKE | `string` | n/a | yes |
| <a name="input_knamespace"></a> [knamespace](#input\_knamespace) | Kubernetes Namespace | `string` | n/a | yes |
| <a name="input_ksa"></a> [ksa](#input\_ksa) | Kubernetes service account | `string` | n/a | yes |
| <a name="input_remote_state_org_state_bucket"></a> [remote\_state\_org\_state\_bucket](#input\_remote\_state\_org\_state\_bucket) | Name of the GCS bucket the contains the terraform state file for the Org resources | `string` | n/a | yes |
| <a name="input_remote_state_org_state_prefix"></a> [remote\_state\_org\_state\_prefix](#input\_remote\_state\_org\_state\_prefix) | GCS object prefix of the terraform state file for the Org resources | `string` | n/a | yes |
| <a name="input_remote_state_proj_state_bucket"></a> [remote\_state\_proj\_state\_bucket](#input\_remote\_state\_proj\_state\_bucket) | Name of the GCS bucket the contains the terraform state file for the Org resources | `string` | n/a | yes |
| <a name="input_remote_state_proj_state_prefix"></a> [remote\_state\_proj\_state\_prefix](#input\_remote\_state\_proj\_state\_prefix) | GCS object prefix of the terraform state file for the Org resources | `string` | n/a | yes |
| <a name="input_remote_state_vpc_state_prefix"></a> [remote\_state\_vpc\_state\_prefix](#input\_remote\_state\_vpc\_state\_prefix) | GCS object prefix of the terraform state file for the vpc resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_hostname"></a> [bastion\_hostname](#output\_bastion\_hostname) | Bastion IP address |
| <a name="output_bastion_ip"></a> [bastion\_ip](#output\_bastion\_ip) | Bastion IP address |
| <a name="output_gke_cluster_id"></a> [gke\_cluster\_id](#output\_gke\_cluster\_id) | Cluster ID |
| <a name="output_gke_endpoint"></a> [gke\_endpoint](#output\_gke\_endpoint) | Cluster endpoint |
| <a name="output_gke_location"></a> [gke\_location](#output\_gke\_location) | Cluster location (region if regional cluster, zone if zonal cluster) |
| <a name="output_gke_master_ipv4_cidr_block"></a> [gke\_master\_ipv4\_cidr\_block](#output\_gke\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation used for the hosted master network |
| <a name="output_gke_name"></a> [gke\_name](#output\_gke\_name) | Cluster name |
| <a name="output_gke_node_pools_names"></a> [gke\_node\_pools\_names](#output\_gke\_node\_pools\_names) | List of node pools names |
| <a name="output_gke_node_pools_versions"></a> [gke\_node\_pools\_versions](#output\_gke\_node\_pools\_versions) | List of node pools versions |
| <a name="output_gke_service_account"></a> [gke\_service\_account](#output\_gke\_service\_account) | The service account to default running nodes as if not overridden in `node_pools`. |
| <a name="output_gke_type"></a> [gke\_type](#output\_gke\_type) | Cluster type (regional / zonal) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
