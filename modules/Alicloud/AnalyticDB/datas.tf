data "alicloud_zones" "this" {
  available_resource_creation = var.zone
}

data "alicloud_vpcs" "this" {
  vpc_name = var.vpc
}

data "alicloud_vswitches" "this" {
  vpc_id       = data.alicloud_vpcs.this.id
  zone_id      = data.alicloud_zones.this.zone[0].id
  vswitch_name = var.vswitch
}
