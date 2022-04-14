output "bastion_ip" {
  description = "Bastion IP address"
  value       = module.bastion_host.ip_address
}

output "bastion_hostname" {
  description = "Bastion IP address"
  value       = module.bastion_host.hostname
}
