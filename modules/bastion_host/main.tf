module "bastion_host" {
  source                     = "terraform-google-modules/bastion-host/google"
  version                    = "4.0.0"
  name                       = var.name
  fw_name_allow_ssh_from_iap = var.firewall_rule_name
  service_account_email      = var.service_account_email
  project                    = var.project
  zone                       = var.zone
  network                    = var.network
  subnet                     = var.subnet
  members                    = var.members
  image_family               = var.image_family
  machine_type               = var.machine_type
  host_project               = var.host_project
  startup_script             = "#! /bin/bash \n  yum install kubectl -y"
}
