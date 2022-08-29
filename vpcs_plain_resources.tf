## Create VPCs
resource "google_compute_network" "vpc" {
  for_each                = var.vpcs
  name                    = "${each.value.name}-${var.environment_prefix}"
  auto_create_subnetworks = false
  project                 = var.environment_project
}


