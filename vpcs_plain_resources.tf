## Create VPCs
resource "google_compute_network" "vpc" {
  for_each                = var.vpcs
  name                    = "${each.value.name}-${var.environment_prefix}"
  auto_create_subnetworks = false
  project                 = var.environment_project
}


# module "vpcs" {
  # source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc?ref=v16.0.0"
  # project_id = var.environment_project
  # for_each   = var.vpcs
  # name       = "${each.value.name}-${var.environment_prefix}"
  # subnets    = each.value.subnets
# }

locals {
  subnets = flatten( [
    for vpc_key, vpc in var.vpcs : [
      for subnet_key, subnet in vpc.subnets : {
        vpc_key = vpc_key
        name = subnet.name
        ip_cidr_range = subnet.ip_cidr_range
        region = subnet.region
        secondary_ip_range = subnet.secondary_ip_range
      }
    ]
    ])
} 

resource "google_compute_subnetwork" "main" {
for_each = {for i in local.subnets : "${i.vpc_key}.${i.name}" => i } 
  name                    = "${each.value.name}-${var.environment_prefix}"
  ip_cidr_range           = "${each.value.ip_cidr_range}"
  region                  = "${each.value.region}"
  network                 = google_compute_network.vpc["${each.value.vpc_key}"].self_link
  secondary_ip_range = each.value.secondary_ip_range == null ? [] : [
    for name, range in each.value.secondary_ip_range :
    { range_name = name, ip_cidr_range = range }
  ]
}