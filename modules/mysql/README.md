# MySQL Module

This module creates a MySQL instance. The following DB versions can be used MYSQL_5_6, MYSQL_5_7, MYSQL_8_0

**NOTE:** `deletion_protection` variable is used in this module to block terraform from destroying SQL instance. Please make sure to set this field to false, if you want terraform to destroy SQL instance otherwise terraform apply or terraform destroy will fail.
## Usage

```hcl
module "mysql_db" {
  source                          = "../../modules/mysql"
  gcp_region                      = var.gcp_region
  host_project_id                 = data.terraform_remote_state.proj_state.outputs.dev_project_id
  database_version                = "MYSQL_5_7"
  instance_zone                   = "europe-west3-a" # Frankfurt
  instance_name                   = "test"
  disk_size                       = 10 # GB
  disk_autoresize                 = true
  create_random_instance_suffix   = true # needed because names must be unique
  availability_type               = "REGIONAL" # ZONAL or REGIONAL 
  maintenance_window_day          = 3 # Wednesday
  maintenance_window_hour         = 5 # 05:00 AM UTC = 06:00 AM in UTC+1 (german winter time MEZ) 
  maintenance_window_update_track = "stable"
  backup_start_time               = "02:00" # 02:00 AM UTC = 03:00 AM in UTC+1
  days_of_backups_retained        = 4 
  days_of_trans_logs_retained     = 3 
  # NOTE: Either enable_public_internet_access or private_network variable should be set
  enable_public_internet_access = false
  private_network               = "projects/${data.terraform_remote_state.proj_state.outputs.dev_project_id}/global/networks/wilson-local-net"
  authorized_networks           = []
  require_ssl                   = true
  labels                        = { env : "test" }
  database_flags = [
  {
    name  = "cloudsql_iam_authentication"
    value = "on"
  }]
  deletion_protection           = false
  resource_timeout              = "30m"
}
```
## How to configure High Availability ?
The configuration is set to REGIONAL availability type where primary instance (master) in primary zone (instance_zone) is declared in specified variables and secondary zone is selected by default. 
In our case we select primary zone `europe-west3-a` and secondary zone will be selected as `europe-west3-b` if we define REGIONAL availability type.

## Types of Backups
1. *On-demand backups*

    You can manually take backup of your instance at any time without waiting for backup window or if you are performing risky operation on database. On-demand backups are **NOT** automatically deleted, they persist until you delete them or instance is deleted.
2. *Automated backups*

    Automated backup uses 4 hour backup window. By default upto 7 most recent backups are retained.

### Transaction Log and Automated Backup 
Automated backups are retained for upto an year (365 days). Transaction log are counted in days and can be set from 1 to 7
### About Backup size
Cloud SQL backups are incremental. They contain only data that changed after the previous backup was taken. Your oldest backup is a similar size to your database, but the sizes of subsequent backups depend on the rate of change of your data.

### For more details on backup
https://cloud.google.com/sql/docs/mysql/backup-recovery/backups?&_ga=2.104477831.-60397371.1634898689#retention

## How to limit SQL auto storage ?
1. Select the project where SQL instance is hosted
    ```console
    gcloud projects list
    ```
2. Copy the project Id, if you're not sure which Id to copy. Goto GCP console in Browser, select top left project/folder dropdown then goto ALL tab, you can find all your projects under your name in team-03 folder now you can also copy ID infront of project name.
3. Paste your copied project name in the defined section under following command 
    ```console
    gcloud config set project <your-copied-project-Id>
    ```
4. Now, let's Check SQL instance name
    ```console
    gcloud beta sql instances list
    ```
5. Copy the instance name and paste it in the defined section under following command
    ```console
    gcloud beta sql instances patch <paste_instance_name> --storage-auto-increase-limit=20
    ```

*Note:* This change IS NOT inside terraform state so with the next `terraform apply` this setting is reset (=no storage-auto-increase-limit)

## How to see the defail generated password

When you run `terraform apply` in the output section you will see that a password is sensitive data:

```
Outputs:
.
.
.
test_user_02_password = <sensitive>
```

You can prompt the real password with:

```
terraform output test_user_02_password 
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mysql"></a> [mysql](#module\_mysql) | GoogleCloudPlatform/sql-db/google//modules/mysql | 8.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorized_networks"></a> [authorized\_networks](#input\_authorized\_networks) | List of networks which are authorized to access SQL instance. Name (optional), Value is a CIDR notation IPv4 address that is allowed to access this SQL instance. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | The availability type for the master instance. Can be either REGIONAL (High Available) or ZONAL (Single Zone). REGIONAL enables automatic backup, point in time recovery and auto storage increase | `string` | `"REGIONAL"` | no |
| <a name="input_backup_start_time"></a> [backup\_start\_time](#input\_backup\_start\_time) | Backup time window - start time + 4 hours is the window in which SQL automated backups will be taken. | `string` | n/a | yes |
| <a name="input_create_random_instance_suffix"></a> [create\_random\_instance\_suffix](#input\_create\_random\_instance\_suffix) | Sets random suffix at the end of the Cloud SQL resource name | `bool` | `true` | no |
| <a name="input_create_resource_timeout"></a> [create\_resource\_timeout](#input\_create\_resource\_timeout) | The optional timout for instance creation that is applied to limit long database updates. Valid units of time are s, m, h. | `string` | `"15m"` | no |
| <a name="input_database_flags"></a> [database\_flags](#input\_database\_flags) | List of Cloud SQL flags that are applied to the database server. See more details here -> https://cloud.google.com/sql/docs/mysql/flags | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | Version of the database. e.g MYSQL\_5\_7, POSTGRES\_9\_6 | `string` | n/a | yes |
| <a name="input_days_of_backups_retained"></a> [days\_of\_backups\_retained](#input\_days\_of\_backups\_retained) | n/a | `number` | n/a | yes |
| <a name="input_days_of_trans_logs_retained"></a> [days\_of\_trans\_logs\_retained](#input\_days\_of\_trans\_logs\_retained) | n/a | `number` | n/a | yes |
| <a name="input_delete_resource_timeout"></a> [delete\_resource\_timeout](#input\_delete\_resource\_timeout) | The optional timout for deletion of instance that is applied to limit long database updates. Valid units of time are s, m, h. | `string` | `"20m"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Used to block Terraform from deleting a SQL Instance | `bool` | n/a | yes |
| <a name="input_disk_autoresize"></a> [disk\_autoresize](#input\_disk\_autoresize) | Configuration to increase storage size, defaults to true | `bool` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size for master Sql instance in GBs | `number` | n/a | yes |
| <a name="input_enable_public_internet_access"></a> [enable\_public\_internet\_access](#input\_enable\_public\_internet\_access) | Enable IPv4 access. Only enable if you want your database open to internet | `bool` | `false` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | GCP Region | `string` | n/a | yes |
| <a name="input_host_project_id"></a> [host\_project\_id](#input\_host\_project\_id) | To create SQL instances in that parent project Id | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name of Cloud SQL Instance | `string` | n/a | yes |
| <a name="input_instance_zone"></a> [instance\_zone](#input\_instance\_zone) | Preferred zone for the master instance (e.g. 'europe-west3-a'). If null, Google will auto-assign a zone. | `string` | `"europe-west3-a"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of custom labels to apply to the instance. | `map(string)` | `{}` | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | The day of week (1-7) for the master instance maintenance. (e.g 1-Monday -> 7-Sunday) | `number` | `3` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | The hour of day (0-23) maintenance window for the master instance maintenance. | `number` | `6` | no |
| <a name="input_maintenance_window_update_track"></a> [maintenance\_window\_update\_track](#input\_maintenance\_window\_update\_track) | The update track of maintenance window for the master instance maintenance. Can be either canary or stable. Defaults to Canary | `string` | `"stable"` | no |
| <a name="input_master_disk_type"></a> [master\_disk\_type](#input\_master\_disk\_type) | The disk type for the master instance. | `string` | `"PD_SSD"` | no |
| <a name="input_master_tier"></a> [master\_tier](#input\_master\_tier) | The tier for the master instance. | `string` | n/a | yes |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | (Optional) The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP. At least ipv4\_enabled (enable\_public\_internet\_access) must be enabled or a private\_network must be configured. This setting can be updated, but it cannot be removed after it is set. | `string` | `null` | no |
| <a name="input_read_replica_deletion_protection"></a> [read\_replica\_deletion\_protection](#input\_read\_replica\_deletion\_protection) | Used to block Terraform from deleting replica SQL Instances. | `bool` | `false` | no |
| <a name="input_read_replica_name_suffix"></a> [read\_replica\_name\_suffix](#input\_read\_replica\_name\_suffix) | Optional suffix to add to instance name | `string` | `""` | no |
| <a name="input_read_replicas"></a> [read\_replicas](#input\_read\_replicas) | List of read replicas to create. Replicas can be created on different zones, if different regions is required then encryption key is required. | <pre>list(object({<br>    name            = string<br>    tier            = string<br>    zone            = string<br>    disk_type       = string<br>    disk_autoresize = bool<br>    disk_size       = string<br>    user_labels     = map(string)<br>    database_flags = list(object({<br>      name  = string<br>      value = string<br>    }))<br>    ip_configuration = object({<br>      authorized_networks = list(map(string))<br>      ipv4_enabled        = bool<br>      private_network     = string<br>      require_ssl         = bool<br>    })<br>    encryption_key_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_require_ssl"></a> [require\_ssl](#input\_require\_ssl) | Whether SSL connections over IP are enforced or not. Defaults to true | `bool` | `true` | no |
| <a name="input_update_resource_timeout"></a> [update\_resource\_timeout](#input\_update\_resource\_timeout) | The optional timout for updating instance that is applied to limit long database updates. Valid units of time are s, m, h. | `string` | `"15m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | The connection name of the master instance to be used in connection strings |
| <a name="output_master_instance_name"></a> [master\_instance\_name](#output\_master\_instance\_name) | SQL Master Instance Name |
| <a name="output_master_instance_self_link"></a> [master\_instance\_self\_link](#output\_master\_instance\_self\_link) | The URI of the master instance |
| <a name="output_master_tier"></a> [master\_tier](#output\_master\_tier) | SQL Master Instance tier |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | The private IP address assigned for the master instance |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The first public (PRIMARY) IPv4 address assigned for the master instance |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
