output "master_instance_name" {
  value       = module.mysql.instance_name
  description = "SQL Master Instance Name"
}
output "master_instance_self_link" {
  value       = module.mysql.instance_self_link
  description = "The URI of the master instance"
}
output "private_ip_addresses" {
  value       = module.mysql.private_address
  description = "The private IP address assigned for the master instance"
}
output "public_ip_address" {
  value       = module.mysql.public_ip_address
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance"
}
output "master_tier" {
  value       = var.master_tier
  description = "SQL Master Instance tier"
}
output "instance_connection_name" {
  value       = module.mysql.instance_connection_name
  description = "The connection name of the master instance to be used in connection strings"
}
