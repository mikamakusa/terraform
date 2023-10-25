resource "alicloud_vpc" "this" {
  count                = length(var.vpc)
  vpc_name             = lookup(var.vpc[count.index], "vpc_name")
  cidr_block           = lookup(var.vpc[count.index], "cidr_block")
  classic_link_enabled = lookup(var.vpc[count.index], "classic_link_enabled")
  description          = lookup(var.vpc[count.index], "description")
  dry_run              = lookup(var.vpc[count.index], "dry_run")
  enable_ipv6          = lookup(var.vpc[count.index], "enable_ipv6")
  ipv6_isp             = lookup(var.vpc[count.index], "ipv6_isp")
  resource_group_id    = lookup(var.vpc[count.index], "resource_group_id")
  tags = merge(
    var.tags,
    lookup(var.vpc[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  user_cidrs = lookup(var.vpc[count.index], "user_cidrs")
}

resource "alicloud_vswitch" "this" {
  count                = length(var.vswitch)
  vswitch_name         = lookup(var.vswitch[count.index], "vswitch_name")
  cidr_block           = lookup(var.vswitch[count.index], "cidr_block")
  vpc_id               = var.vpcs ? data.alicloud_vpcs.this.vpcs.0.id : element(alicloud_vpc.this.*.id, lookup(var.vswitch[count.index], "vpc_id"))
  description          = lookup(var.vswitch[count.index], "description")
  zone_id              = data.alicloud_zones.this.zones.0.id
  enable_ipv6          = lookup(var.vswitch[count.index], "enable_ipv6")
  ipv6_cidr_block_mask = lookup(var.vswitch[count.index], "ipv6_cidr_block_mask")
  tags = merge(
    var.tags,
    lookup(var.vswitch[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_resource_manager_resource_group" "this" {
  count               = length(var.resource_group)
  display_name        = lookup(var.resource_group[count.index], "display_name")
  resource_group_name = lookup(var.resource_group[count.index], "resource_group_name")
}

resource "alicloud_security_group" "this" {
  count               = length(var.security_group)
  name                = lookup(var.security_group[count.index], "name")
  description         = lookup(var.security_group[count.index], "description")
  vpc_id              = var.vpcs ? data.alicloud_vpcs.this.vpcs.0.id : element(alicloud_vpc.this.*.id, lookup(var.security_group[count.index], "vpc_id"))
  resource_group_id   = var.resource_groups ? data.alicloud_resource_manager_resource_groups.this.groups.0.id : element(alicloud_resource_manager_resource_group.this.*.id, lookup(var.security_group[count.index], "resource_group_id"))
  security_group_type = lookup(var.security_group[count.index], "security_group_type")
  inner_access_policy = lookup(var.security_group[count.index], "inner_access_policy")
  tags = merge(
    var.tags,
    lookup(var.vswitch[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_kms_key" "this" {
  count                  = length(var.kms_key)
  description            = lookup(var.kms_key[count.index], "description")
  key_usage              = lookup(var.kms_key[count.index], "key_usage")
  automatic_rotation     = lookup(var.kms_key[count.index], "automatic_rotation")
  key_spec               = lookup(var.kms_key[count.index], "key_spec")
  status                 = lookup(var.kms_key[count.index], "status")
  origin                 = lookup(var.kms_key[count.index], "origin")
  pending_window_in_days = lookup(var.kms_key[count.index], "pending_window_in_days")
  protection_level       = lookup(var.kms_key[count.index], "protection_level")
  rotation_interval      = lookup(var.kms_key[count.index], "rotation_interval")
  tags = merge(
    var.tags,
    lookup(var.kms_key[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_alikafka_instance" "this" {
  count           = length(var.alikafka_instance)
  deploy_type     = lookup(var.alikafka_instance[count.index], "deploy_type")
  disk_size       = lookup(var.alikafka_instance[count.index], "disk_size")
  disk_type       = lookup(var.alikafka_instance[count.index], "disk_type")
  vswitch_id      = var.vswitches ? data.alicloud_vswitches.this.id : element(alicloud_vswitch.this.*.id, lookup(var.alikafka_instance[count.index], "vswitch_id"))
  name            = lookup(var.alikafka_instance[count.index], "name")
  partition_num   = lookup(var.alikafka_instance[count.index], "partition_num")
  io_max          = lookup(var.alikafka_instance[count.index], "io_max")
  io_max_spec     = lookup(var.alikafka_instance[count.index], "io_max_spec")
  eip_max         = lookup(var.alikafka_instance[count.index], "eip_max")
  paid_type       = lookup(var.alikafka_instance[count.index], "paid_type")
  spec_type       = lookup(var.alikafka_instance[count.index], "spec_type")
  security_group  = var.security_groups ? data.alicloud_security_groups.this.id : element(alicloud_security_group.this.*.id, lookup(var.alikafka_instance[count.index], "security_group_id"))
  service_version = lookup(var.alikafka_instance[count.index], "service_version")
  config          = lookup(var.alikafka_instance[count.index], "config")
  kms_key_id      = var.kms_keys ? data.alicloud_kms_keys.this.keys.0.id : element(alicloud_kms_key.this.*.id, lookup(var.alikafka_instance[count.index], "kms_key_id"))
  tags = merge(
    var.tags,
    lookup(var.alikafka_instance[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  vpc_id         = var.vpcs ? data.alicloud_vpcs.this.id : element(alicloud_vpc.this.*.id, lookup(var.alikafka_instance[count.index], "vpc_id"))
  zone_id        = data.alicloud_zones.this.zones.0.id
  selected_zones = lookup(var.alikafka_instance[count.index], "selected_zones")
}

resource "alicloud_alikafka_instance_allowed_ip_attachment" "this" {
  count        = length(var.allowed_ip_attachment)
  allowed_ip   = lookup(var.allowed_ip_attachment[count.index], "allowed_ip")
  allowed_type = lookup(var.allowed_ip_attachment[count.index], "allowed_type")
  instance_id  = var.kafka_instances ? data.alicloud_alikafka_instances.this.instances.0.name : element(alicloud_alikafka_instance.this.*.id, lookup(var.allowed_ip_attachment[count.index], "instance_id"))
  port_range   = lookup(var.allowed_ip_attachment[count.index], "port_range")
}

resource "alicloud_alikafka_topic" "this" {
  count         = length(var.topic)
  instance_id   = var.kafka_instances ? data.alicloud_alikafka_instances.this.instances.0.name : element(alicloud_alikafka_instance.this.*.id, lookup(var.topic[count.index], "instance_id"))
  remark        = lookup(var.topic[count.index], "remark")
  topic         = lookup(var.topic[count.index], "topic")
  local_topic   = lookup(var.topic[count.index], "local_topic")
  compact_topic = lookup(var.topic[count.index], "compact_topic")
  partition_num = lookup(var.topic[count.index], "partition_num")
  tags = merge(
    var.tags,
    lookup(var.topic[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_alikafka_sasl_user" "this" {
  count       = length(var.sasl_user)
  instance_id = var.kafka_instances ? data.alicloud_alikafka_instances.this.instances.0.name : element(alicloud_alikafka_instance.this.*.id, lookup(var.sasl_user[count.index], "instance_id"))
  username    = lookup(var.sasl_user[count.index], "username")
  password    = sensitive(lookup(var.sasl_user[count.index], "password"))
  type        = lookup(var.sasl_user[count.index], "type")
}

resource "alicloud_alikafka_sasl_acl" "this" {
  count                     = length(var.sasl_acl)
  acl_operation_type        = lookup(var.sasl_acl[count.index], "acl_operation_type")
  acl_resource_name         = lookup(var.sasl_acl[count.index], "acl_resource_name")
  acl_resource_pattern_type = lookup(var.sasl_acl[count.index], "acl_resource_pattern_type")
  acl_resource_type         = lookup(var.sasl_acl[count.index], "acl_resource_type")
  instance_id               = var.kafka_instances ? data.alicloud_alikafka_instances.this.instances.0.name : element(alicloud_alikafka_instance.this.*.id, lookup(var.sasl_acl[count.index], "instance_id"))
  username                  = lookup(var.sasl_acl[count.index], "username")
}

resource "alicloud_alikafka_consumer_group" "this" {
  count       = length(var.consumer_group)
  consumer_id = lookup(var.consumer_group[count.index], "consumer_id")
  instance_id = var.kafka_instances ? data.alicloud_alikafka_instances.this.instances.0.name : element(alicloud_alikafka_instance.this.*.id, lookup(var.consumer_group[count.index], "instance_id"))
  description = lookup(var.consumer_group[count.index], "description")
  tags = merge(
    var.tags,
    lookup(var.consumer_group[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}