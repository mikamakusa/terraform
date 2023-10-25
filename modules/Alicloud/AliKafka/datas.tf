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

data "alicloud_alikafka_instances" "this" {
  count      = var.kafka_instances ? 1 : 0
  name_regex = var.kafka_instances
}
