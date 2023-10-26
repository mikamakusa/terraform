data "alicloud_threat_detection_honeypot_images" "this" {
  count      = var.honeypot_images ? 1 : 0
  name_regex = var.honeypot_images
}

data "alicloud_threat_detection_assets" "this" {
  count         = var.assets ? 1 : 0
  machine_types = var.assets
}

data "alicloud_vpcs" "this" {
  count      = var.vpcs ? 1 : 0
  name_regex = var.vpcs
}