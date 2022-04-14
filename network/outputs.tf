output "subnets" {
  description = "VPC network subnets and their details"
  value       = module.vpc.subnets
}

output "network_name" {
  description = "VPC network name"
  value       = module.vpc.network_name
}

output "project_id" {
  description = "GCP Project ID"
  value       = module.vpc.project_id
}

output "network_self_link" {
  description = "Self link for the network"
  value       = module.vpc.network_self_link
}
