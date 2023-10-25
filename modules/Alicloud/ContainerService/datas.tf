data "alicloud_zones" "this" {
  count                       = var.available_resource_creation ? 1 : 0
  available_resource_creation = var.available_resource_creation
}

data "alicloud_vpcs" "this" {
  count      = var.vpcs ? 1 : 0
  name_regex = var.vpcs
}

data "alicloud_vswitches" "this" {
  count      = var.vswitches ? 1 : 0
  name_regex = var.vswitches
}

data "alicloud_security_groups" "this" {
  count      = var.security_groups ? 1 : 0
  name_regex = var.security_groups
}

data "alicloud_resource_manager_resource_groups" "this" {
  count      = var.resource_groups ? 1 : 0
  name_regex = var.resource_groups
}

data "alicloud_kms_keys" "this" {
  count             = var.kms_keys ? 1 : 0
  description_regex = var.kms_keys
  status            = "Enabled"
}

data "alicloud_db_instances" "this" {
  count      = var.db_instances ? 1 : 0
  name_regex = var.db_instances
  status     = "Running"
}

data "alicloud_slb_load_balancers" "this" {
  count      = var.load_balancers ? 1 : 0
  name_regex = var.load_balancers
}

data "alicloud_ess_scaling_groups" "this" {
  count      = var.ess_scaling_groups ? 1 : 0
  name_regex = var.ess_scaling_groups
}

data "alicloud_images" "this" {
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}
data "alicloud_instance_types" "this" {
  availability_zone    = data.alicloud_zones.this.zones.0.id
  cpu_core_count       = 4
  memory_size          = 8
  kubernetes_node_role = "Worker"
}

data "alicloud_ess_scaling_configurations" "this" {
  count      = var.ess_scaling_configurations ? 1 : 0
  name_regex = var.ess_scaling_configurations
}