# Buckets module

This module creates GCS bucket

### Usage

```hcl
module "buckets" {
  source = "../buckets"

  project_id      = module.project_factory.project_id
  names           = var.bucket_names
  prefix          = var.state_bucket_name_prefix
  set_admin_roles = true
  storage_admins  = ["serviceAccount:${module.service_account.sa_email}"] 
  versioning      = var.bucket_versioning
  bucket_admins   = var.bucket_admins
  object_admins   = ["serviceAccount:${module.service_account.sa_email}"] 
  storage_class   = var.state_bucket_storage_class
  location        = var.gcp_region
  force_destroy   = var.bucket_force_destroy
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcs_buckets"></a> [gcs\_buckets](#module\_gcs\_buckets) | terraform-google-modules/cloud-storage/google | 3.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_admins"></a> [bucket\_admins](#input\_bucket\_admins) | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket admins | `map(string)` | `{}` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Forcefully destroy a bucket, even if it is not empty. bucketname => boolean | `map(bool)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Bucket location, defaults to EU | `string` | `"EU"` | no |
| <a name="input_names"></a> [names](#input\_names) | Bucket name suffixes | `list(string)` | `[]` | no |
| <a name="input_object_admins"></a> [object\_admins](#input\_object\_admins) | IAM-style members who will be granted roles/storage.objectAdmin on all buckets | `list(string)` | `[]` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used to generate the bucket name, defaults to null | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | A project to create a GCS bucket (bucket\_name) in, useful for Terraform state (optional) | `string` | n/a | yes |
| <a name="input_set_admin_roles"></a> [set\_admin\_roles](#input\_set\_admin\_roles) | Grant roles/storage.objectAdmin role to admins and bucket\_admins, defaults to false | `bool` | `false` | no |
| <a name="input_storage_admins"></a> [storage\_admins](#input\_storage\_admins) | IAM-style members who will be granted roles/storage.objectAdmin on all buckets | `list(string)` | `[]` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Bucket storage class, defaults to STANDARD | `string` | `"STANDARD"` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Bucket Versioning - bucket-name => boolean | `map(bool)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | Bucket names |
| <a name="output_buckets_url"></a> [buckets\_url](#output\_buckets\_url) | Bucket URLS |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
