# App Dev Project


## Usage
---
1. Copy terraform.tfvars-example to terraform.tfvars:
    ```
    $ cp terraform.tfvars-example terraform.tfvars
    ```

2. Update terraform.tfvars file with values from your environment.

    1. Update the value of remote_state_proj_state_bucket with the bucket name that you defined earlier for projects.
        ```
        remote_state_proj_state_bucket = "p7s1-projects-<your-name-prefix>"
        ```

3. Copy remotestate.tf-example to resources/app_dev_project
   ```
    $ cp remotestate.tf-example remotestate.tf
   ```
   1. Update the value of bucket name prefix with your name
        ```
        bucket = "<your-name-prefix>-europe-west3-dev-app"
        ```
4. Goto DB.tf files where you can update the following params, labels where sql_labels module is called, sql instance, sql database, sql users.
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
Service Account Impersonation -> Output of remote state of project_state App Dev service account

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
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mysql_db"></a> [mysql\_db](#module\_mysql\_db) | ../../modules/mysql | n/a |
| <a name="module_sql_labels"></a> [sql\_labels](#module\_sql\_labels) | ../../modules/labels | n/a |

## Resources

| Name | Type |
|------|------|
| [google_sql_database.test_database_01](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/sql_database) | resource |
| [google_sql_user.test_user_01](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/sql_user) | resource |
| [google_sql_user.test_user_02](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/sql_user) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/data-sources/client_config) | data source |
| [google_service_account_access_token.sa](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/data-sources/service_account_access_token) | data source |
| [terraform_remote_state.org_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.proj_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | GCP Region | `string` | n/a | yes |
| <a name="input_remote_state_org_state_bucket"></a> [remote\_state\_org\_state\_bucket](#input\_remote\_state\_org\_state\_bucket) | Name of the GCS bucket the contains the terraform state file for the Org resources | `string` | n/a | yes |
| <a name="input_remote_state_org_state_prefix"></a> [remote\_state\_org\_state\_prefix](#input\_remote\_state\_org\_state\_prefix) | GCS object prefix of the terraform state file for the Org resources | `string` | n/a | yes |
| <a name="input_remote_state_proj_state_bucket"></a> [remote\_state\_proj\_state\_bucket](#input\_remote\_state\_proj\_state\_bucket) | Name of the GCS bucket the contains the terraform state file for the Projects resources | `string` | n/a | yes |
| <a name="input_remote_state_proj_state_prefix"></a> [remote\_state\_proj\_state\_prefix](#input\_remote\_state\_proj\_state\_prefix) | GCS object prefix of the terraform state file for the Projects resources | `string` | n/a | yes |
| <a name="input_remote_state_vpc_state_prefix"></a> [remote\_state\_vpc\_state\_prefix](#input\_remote\_state\_vpc\_state\_prefix) | GCS object prefix of the terraform state file for the vpc resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | The connection name of the master instance to be used in connection strings |
| <a name="output_master_instance_name"></a> [master\_instance\_name](#output\_master\_instance\_name) | SQL Master Instance Name |
| <a name="output_master_instance_self_link"></a> [master\_instance\_self\_link](#output\_master\_instance\_self\_link) | The URI of the master instance |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | The private IP address assigned for the master instance |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The first public (PRIMARY) IPv4 address assigned for the master instance |
| <a name="output_test_database_01"></a> [test\_database\_01](#output\_test\_database\_01) | Test database details. e.g Id, name, instance, host\_project, self\_link |
| <a name="output_test_user_02_password"></a> [test\_user\_02\_password](#output\_test\_user\_02\_password) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
