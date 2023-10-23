data "alicloud_regions" "this" {
  current = true
}

data "alicloud_account" "this" {}

data "alicloud_ram_roles" "this" {
  count      = var.roles ? 1 : 0
  name_regex = var.roles
}

data "alicloud_oss_buckets" "this" {
  count      = var.buckets ? 1 : 0
  name_regex = var.buckets
}

data "alicloud_mns_topics" "this" {
  count       = var.topics ? 1 : 0
  name_prefix = var.topics
}

data "alicloud_ram_roles" "sls_role" {
  count      = var.log_project ? 1 : 0
  name_regex = var.log_project
}

data "alicloud_log_projects" "this" {
  count      = var.log_project ? 1 : 0
  name_regex = var.log_project
}
