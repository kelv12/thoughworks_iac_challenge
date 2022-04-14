# Bastion Host Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion_host"></a> [bastion\_host](#module\_bastion\_host) | terraform-google-modules/bastion-host/google | 4.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_rule_name"></a> [firewall\_rule\_name](#input\_firewall\_rule\_name) | Firewall rule name for allowing SSH from IAP | `string` | `"allow-ssh-from-iap-to-tunnel"` | no |
| <a name="input_host_project"></a> [host\_project](#input\_host\_project) | Network host project | `string` | n/a | yes |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | Bastion image family | `string` | `"centos-8"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Bastion machine type | `string` | `"n1-standard-1"` | no |
| <a name="input_members"></a> [members](#input\_members) | Bastion IAP users | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Bastion instance | `string` | `"bastion"` | no |
| <a name="input_network"></a> [network](#input\_network) | Bastion network | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Bastion service account | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Bastion subnet | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Bastion network zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_hostname"></a> [bastion\_hostname](#output\_bastion\_hostname) | Bastion IP address |
| <a name="output_bastion_ip"></a> [bastion\_ip](#output\_bastion\_ip) | Bastion IP address |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
