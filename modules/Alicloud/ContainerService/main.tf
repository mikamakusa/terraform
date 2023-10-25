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

resource "alicloud_db_instance" "this" {
  count                          = length(var.db_instance)
  engine                         = lookup(var.db_instance[count.index], "engine")
  engine_version                 = lookup(var.db_instance[count.index], "engine_version")
  instance_storage               = lookup(var.db_instance[count.index], "instance_storage")
  instance_type                  = lookup(var.db_instance[count.index], "instance_type")
  db_instance_storage_type       = lookup(var.db_instance[count.index], "db_instance_strage_type")
  db_time_zone                   = lookup(var.db_instance[count.index], "db_time_zone")
  sql_collector_status           = lookup(var.db_instance[count.index], "sql_collector_status")
  sql_collector_config_value     = lookup(var.db_instance[count.index], "sql_collector_config_value")
  instance_name                  = lookup(var.db_instance[count.index], "instance_name")
  connection_string_prefix       = lookup(var.db_instance[count.index], "connection_string_prefix")
  port                           = lookup(var.db_instance[count.index], "port")
  instance_charge_type           = lookup(var.db_instance[count.index], "instance_charge_type")
  period                         = lookup(var.db_instance[count.index], "period")
  monitoring_period              = lookup(var.db_instance[count.index], "monitoring_period")
  auto_renew                     = lookup(var.db_instance[count.index], "auto_renew")
  auto_renew_period              = lookup(var.db_instance[count.index], "auto_renew_period")
  zone_id                        = data.alicloud_zones.this.zones.0.id
  vswitch_id                     = var.vswitches ? data.alicloud_vswitches.this.vswitches.0.id : element(alicloud_vswitch.this.*.id, lookup(var.db_instance[count.index], "vswitch_id"))
  private_ip_address             = lookup(var.db_instance[count.index], "private_ip_address")
  security_ips                   = lookup(var.db_instance[count.index], "security_ips")
  db_instance_ip_array_name      = lookup(var.db_instance[count.index], "db_instance_ip_array_name")
  db_instance_ip_array_attribute = lookup(var.db_instance[count.index], "db_instance_ip_array_attribute")
  security_ip_type               = lookup(var.db_instance[count.index], "security_ip_type")
  db_is_ignore_case              = lookup(var.db_instance[count.index], "db_is_ignore_case")
  whitelist_network_type         = lookup(var.db_instance[count.index], "whitelist_network_type")
  modify_mode                    = lookup(var.db_instance[count.index], "modify_mode")
  security_ip_mode               = lookup(var.db_instance[count.index], "security_ip_mode")
  fresh_white_list_readins       = lookup(var.db_instance[count.index], "fresh_white_list_readins")
  force_restart                  = lookup(var.db_instance[count.index], "force_restart")
  tags = merge(
    var.tags,
    lookup(var.db_instance[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  security_group_ids          = var.security_groups ? data.alicloud_security_groups.this.ids : element(alicloud_security_group.this.*.id, lookup(var.db_instance[count.index], "security_group_ids"))
  maintain_time               = lookup(var.db_instance[count.index], "maintain_type")
  auto_upgrade_minor_version  = lookup(var.db_instance[count.index], "auto_upgrade_minor_version")
  upgrade_time                = lookup(var.db_instance[count.index], "upgrade_time")
  switch_time                 = lookup(var.db_instance[count.index], "switch_time")
  target_minor_version        = lookup(var.db_instance[count.index], "target_minor_version")
  zone_id_slave_a             = lookup(var.db_instance[count.index], "zone_id_slave_a")
  zone_id_slave_b             = lookup(var.db_instance[count.index], "zone_id_slave_b")
  ssl_action                  = lookup(var.db_instance[count.index], "ssl_action")
  ssl_connection_string       = lookup(var.db_instance[count.index], "ssl_connection_string")
  tde_status                  = lookup(var.db_instance[count.index], "tde_status")
  encryption_key              = var.kms_keys ? data.alicloud_kms_keys.this.keys.0.id : element(alicloud_kms_key.this.*.id, lookup(var.db_instance[count.index], "encrpytion_key_id"))
  ca_type                     = lookup(var.db_instance[count.index], "ca_type")
  server_cert                 = lookup(var.db_instance[count.index], "server_cert")
  server_key                  = lookup(var.db_instance[count.index], "server_key")
  client_ca_enabled           = lookup(var.db_instance[count.index], "client_ca_enabled")
  client_crl_enabled          = lookup(var.db_instance[count.index], "client_crl_enabled")
  client_cert_revocation_list = lookup(var.db_instance[count.index], "client_cert_revocation_list")
  acl                         = lookup(var.db_instance[count.index], "acl")
  replication_acl             = lookup(var.db_instance[count.index], "replication_acl")
  ha_config                   = lookup(var.db_instance[count.index], "ha_config")
  manual_ha_time              = lookup(var.db_instance[count.index], "manual_ha_time")
  released_keep_policy        = lookup(var.db_instance[count.index], "released_keep_policy")
  storage_auto_scale          = lookup(var.db_instance[count.index], "storage_auto_scale")
  storage_threshold           = lookup(var.db_instance[count.index], "storage_threshold")
  storage_upper_bound         = lookup(var.db_instance[count.index], "storage_upper_bound")
  deletion_protection         = lookup(var.db_instance[count.index], "deletion_protection")
  tcp_connection_type         = lookup(var.db_instance[count.index], "tcp_connection_type")
  category                    = lookup(var.db_instance[count.index], "category")
  babelfish_port              = lookup(var.db_instance[count.index], "babelfish_port")
  vpc_id                      = var.vpcs ? data.alicloud_vpcs.this.vpcs.0.id : element(alicloud_vpc.this.*.id, lookup(var.db_instance[count.index], "vpc_id"))
  effective_time              = lookup(var.db_instance[count.index], "effective_time")

  dynamic "parameters" {
    for_each = lookup(var.db_instance[count.index], "parameters") == null ? [] : ["parameters"]
    content {
      name  = lookup(parameters.value, "name")
      value = lookup(parameters.value, "value")
    }
  }

  dynamic "babelfish_config" {
    for_each = lookup(var.db_instance[count.index], "babelfish_config") == null ? [] : ["babelfish_config"]
    content {
      babelfish_enabled    = lookup(babelfish_config.value, "babelfish_enabled")
      master_user_password = sensitive(lookup(babelfish_config.value, "master_user_password"))
      master_username      = lookup(babelfish_config.value, "master_username")
      migration_mode       = lookup(babelfish_config.value, "migration_mode")
    }
  }

  dynamic "serverless_config" {
    for_each = lookup(var.db_instance[count.index], "serverless_config") == null ? [] : ["serverless_config"]
    content {
      max_capacity = lookup(serverless_config.value, "max_capacity")
      min_capacity = lookup(serverless_config.value, "min_capacity")
      auto_pause   = lookup(serverless_config.value, "auto_pause")
      switch_force = lookup(serverless_config.value, "switch_force")
    }
  }

  dynamic "pg_hba_conf" {
    for_each = lookup(var.db_instance[count.index], "pg_hba_conf") == null ? [] : ["pg_hba_conf"]
    content {
      address     = lookup(pg_hba_conf.value, "address")
      database    = lookup(pg_hba_conf.value, "database")
      method      = lookup(pg_hba_conf.value, "method")
      priority_id = lookup(pg_hba_conf.value, "priority_id")
      type        = lookup(pg_hba_conf.value, "type")
      user        = lookup(pg_hba_conf.value, "user")
      mask        = lookup(pg_hba_conf.value, "mask")
      option      = lookup(pg_hba_conf.value, "option")
    }
  }
}

resource "alicloud_slb_load_balancer" "this" {
  count                = length(var.load_balancer)
  load_balancer_name   = lookup(var.load_balancer[count.index], "load_balancer_name")
  address_type         = lookup(var.load_balancer[count.index], "address_type")
  internet_charge_type = lookup(var.load_balancer[count.index], "internet_charge_type")
  instance_charge_type = lookup(var.load_balancer[count.index], "instance_charge_type")
  bandwidth            = lookup(var.load_balancer[count.index], "bandwidth")
  vswitch_id           = var.vswitches ? data.alicloud_vswitches.this.vswitches.0.id : element(alicloud_vswitch.this.*.id, lookup(var.load_balancer[count.index], "vswitch_id"))
  load_balancer_spec   = lookup(var.load_balancer[count.index], "load_balancer_spec")
  tags = merge(
    var.tags,
    lookup(var.load_balancer[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  payment_type                   = lookup(var.load_balancer[count.index], "payment_type")
  period                         = lookup(var.load_balancer[count.index], "period")
  delete_protection              = lookup(var.load_balancer[count.index], "delete_protection")
  address_ip_version             = lookup(var.load_balancer[count.index], "address_ip_version")
  address                        = lookup(var.load_balancer[count.index], "address")
  resource_group_id              = var.resource_groups ? data.alicloud_resource_manager_resource_groups.this.groups.0.id : element(alicloud_resource_manager_resource_group.this.*.id, lookup(var.load_balancer[count.index], "resource_group_id"))
  modification_protection_reason = lookup(var.load_balancer[count.index], "modification_protection_reason")
  modification_protection_status = lookup(var.load_balancer[count.index], "modification_protection_status")
  status                         = lookup(var.load_balancer[count.index], "status")
  specification                  = lookup(var.load_balancer[count.index], "specification")
}

resource "alicloud_ess_scaling_group" "this" {
  count                                    = length(var.ess_scaling_group)
  max_size                                 = lookup(var.ess_scaling_group[count.index], "max_size")
  min_size                                 = lookup(var.ess_scaling_group[count.index], "min_size")
  desired_capacity                         = lookup(var.ess_scaling_group[count.index], "desired_capacity")
  scaling_group_name                       = lookup(var.ess_scaling_group[count.index], "scaling_group_name")
  default_cooldown                         = lookup(var.ess_scaling_group[count.index], "default_cooldown")
  vswitch_ids                              = var.vswitches ? data.alicloud_vswitches.this.ids : lookup(alicloud_vswitch.this.*.id, lookup(var.ess_scaling_group[count.index], "vswitch_ids"))
  removal_policies                         = lookup(var.ess_scaling_group[count.index], "removal_policies")
  db_instance_ids                          = var.db_instances ? data.alicloud_db_instances.this.ids : element(alicloud_db_instance.this.*.id, lookup(var.ess_scaling_group[count.index], "db_instance_ids"))
  loadbalancer_ids                         = var.load_balancers ? data.alicloud_slb_load_balancers.this.ids : element(alicloud_slb_load_balancer.this.*.id, lookup(var.ess_scaling_group[count.index], "loadbalancer_ids"))
  multi_az_policy                          = lookup(var.ess_scaling_group[count.index], "multi_az_policy")
  on_demand_percentage_above_base_capacity = lookup(var.ess_scaling_group[count.index], "on_demand_percentage_above_base_capacity")
  on_demand_base_capacity                  = lookup(var.ess_scaling_group[count.index], "on_demand_base_capacity")
  spot_instance_pools                      = lookup(var.ess_scaling_group[count.index], "spot_instance_pools")
  spot_instance_remedy                     = lookup(var.ess_scaling_group[count.index], "spot_instance_remedy")
  group_deletion_protection                = lookup(var.ess_scaling_group[count.index], "group_deletion_protection")
  group_type                               = lookup(var.ess_scaling_group[count.index], "group_type")
  health_check_type                        = lookup(var.ess_scaling_group[count.index], "health_check_type")
  protected_instances                      = lookup(var.ess_scaling_group[count.index], "protected_instances")
  tags = merge(
    var.tags,
    lookup(var.ess_scaling_group[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_ess_scaling_configuration" "this" {
  count             = length(var.scaling_configuration)
  scaling_group_id  = var.ess_scaling_groups ? data.alicloud_ess_scaling_groups.this.groups.0.id : element(alicloud_ess_scaling_group.this.*.id, lookup(var.ess_scaling_group[count.index], "scaling_group_id"))
  image_id          = data.alicloud_images.this.images[0].id
  instance_type     = data.alicloud_instance_types.this.instance_types[0].id
  security_group_id = var.security_groups ? data.alicloud_security_groups.this.groups.0.id : element(alicloud_security_group.this.*.id, lookup(var.scaling_configuration[count.index], "security_group_id"))
  force_delete      = true
  active            = true
  tags = merge(
    var.tags,
    lookup(var.ess_scaling_group[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_cs_managed_kubernetes" "this" {
  count                        = length(var.managed_kubernetes)
  worker_vswitch_ids           = var.vswitches ? data.alicloud_vswitches.this.ids : element(alicloud_vswitch.this.*.id, lookup(var.managed_kubernetes[count.index], "worker_vswitch_ids"))
  name                         = lookup(var.managed_kubernetes[count.index], "name")
  timezone                     = lookup(var.managed_kubernetes[count.index], "timezone")
  resource_group_id            = var.resource_groups ? data.alicloud_resource_manager_resource_groups.this.groups.0.id : element(alicloud_resource_manager_resource_group.this.*.id, lookup(var.managed_kubernetes[count.index], "resource_group_id"))
  version                      = lookup(var.managed_kubernetes[count.index], "version")
  security_group_id            = var.security_groups ? data.alicloud_security_groups.this.groups.0.id : element(alicloud_security_group.this.*.id, lookup(var.managed_kubernetes[count.index], "security_group_id"))
  is_enterprise_security_group = lookup(var.managed_kubernetes[count.index], "is_enterprise_security_group")
  proxy_mode                   = lookup(var.managed_kubernetes[count.index], "proxy_mode")
  cluster_domain               = lookup(var.managed_kubernetes[count.index], "cluster_domain")
  custom_san                   = lookup(var.managed_kubernetes[count.index], "custom_san")
  user_ca                      = lookup(var.managed_kubernetes[count.index], "user_ca")
  deletion_protection          = lookup(var.managed_kubernetes[count.index], "deletion_protection")
  enable_rrsa                  = lookup(var.managed_kubernetes[count.index], "enable_rrsa")
  service_account_issuer       = lookup(var.managed_kubernetes[count.index], "service_account_issuer")
  api_audiences                = lookup(var.managed_kubernetes[count.index], "api_audiences")
  tags = merge(
    var.tags,
    lookup(var.managed_kubernetes[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  cluster_spec                 = lookup(var.managed_kubernetes[count.index], "cluster_spec")
  encryption_provider_key      = var.kms_keys ? data.alicloud_kms_keys.this.keys.0.id : element(alicloud_kms_key.this.*.id, lookup(var.managed_kubernetes[count.index], "encryption_provider_key_id"))
  load_balancer_spec           = lookup(var.managed_kubernetes[count.index], "load_balancer_spec")
  control_plane_log_ttl        = lookup(var.managed_kubernetes[count.index], "control_plane_log_ttl")
  control_plane_log_components = lookup(var.managed_kubernetes[count.index], "control_plane_log_components")
  control_plane_log_project    = lookup(var.managed_kubernetes[count.index], "control_plane_log_project")
  retain_resources             = lookup(var.managed_kubernetes[count.index], "retain_resources")
  pod_cidr                     = lookup(var.managed_kubernetes[count.index], "pod_cidr")
  pod_vswitch_ids              = lookup(var.managed_kubernetes[count.index], "pod_vswitch_ids")
  new_nat_gateway              = lookup(var.managed_kubernetes[count.index], "new_nat_gateway")
  service_cidr                 = lookup(var.managed_kubernetes[count.index], "service_cidr")
  node_cidr_mask               = lookup(var.managed_kubernetes[count.index], "node_cidr_mask")
  slb_internet_enabled         = lookup(var.managed_kubernetes[count.index], "slb_internet_enabled")
  client_cert                  = lookup(var.managed_kubernetes[count.index], "client_cert")
  client_key                   = lookup(var.managed_kubernetes[count.index], "client_key")
  cluster_ca_cert              = lookup(var.managed_kubernetes[count.index], "cluster_ca_cert")
  availability_zone            = lookup(var.managed_kubernetes[count.index], "availability_zone")

  dynamic "addons" {
    for_each = lookup(var.managed_kubernetes[count.index], "addons") == null ? [] : ["addons"]
    content {
      name     = lookup(addons.value, "name")
      config   = lookup(addons.value, "config")
      disabled = lookup(addons.value, "disabled")
    }
  }

  dynamic "worker_data_disks" {
    for_each = lookup(var.managed_kubernetes[count.index], "worker_data_disks") == null ? [] : ["worker_data_disks"]
    content {
      kms_key_id  = var.kms_keys ? data.alicloud_kms_keys.this.keys.0.id : element(alicloud_kms_key.this.*.id, lookup(worker_data_disks.value, "kms_key_id"))
      device      = lookup(worker_data_disks.value, "device")
      name        = lookup(worker_data_disks.value, "name")
      snapshot_id = lookup(worker_data_disks.value, "snapshot_id")
    }
  }

  dynamic "maintenance_window" {
    for_each = lookup(var.managed_kubernetes[count.index], "maintenance_window") == null ? [] : ["maintenance_window"]
    content {
      duration         = lookup(maintenance_window.value, "duration")
      enable           = lookup(maintenance_window.value, "enable")
      maintenance_time = lookup(maintenance_window.value, "maintenance_time")
      weekly_period    = lookup(maintenance_window.value, "weekly_period")
    }
  }

  dynamic "log_config" {
    for_each = lookup(var.managed_kubernetes[count.index], "log_config") == null ? [] : ["log_config"]
    content {
      type    = lookup(log_config.value, "type")
      project = lookup(log_config.value, "project")
    }
  }

  dynamic "taints" {
    for_each = lookup(var.managed_kubernetes[count.index], "taints") == null ? [] : ["taints"]
    content {
      key    = lookup(taints.value, "key")
      value  = lookup(taints.value, "value")
      effect = lookup(taints.value, "effect")
    }
  }
}

resource "alicloud_cs_autoscaling_config" "this" {
  count                     = length(var.managed_kubernetes) != null && length(var.autoscaling_config) != null
  cluster_id                = element(alicloud_cs_managed_kubernetes.this.*.id, lookup(var.autoscaling_config[count.index], "cluster_id"))
  cool_down_duration        = lookup(var.autoscaling_config[count.index], "cool_down_duration")
  unneeded_duration         = lookup(var.autoscaling_config[count.index], "unneeded_duration")
  utilization_threshold     = lookup(var.autoscaling_config[count.index], "utilization_threshold")
  gpu_utilization_threshold = lookup(var.autoscaling_config[count.index], "gpu_utilization_threshold")
  scan_interval             = lookup(var.autoscaling_config[count.index], "scan_interval")
  scale_down_enabled        = lookup(var.autoscaling_config[count.index], "scale_down_enabled")
  expander                  = lookup(var.autoscaling_config[count.index], "expander")
}

resource "alicloud_cs_edge_kubernetes" "this" {
  count                        = length(var.edge_kubernetes)
  worker_instance_types        = [data.alicloud_instance_types.this.instance_types.0.id]
  worker_number                = lookup(var.edge_kubernetes[count.index], "worker_number")
  worker_vswitch_ids           = var.vswitches ? data.alicloud_vswitches.this.ids : element(alicloud_vswitch.this.*.id, lookup(var.edge_kubernetes[count.index], "vswitch_ids"))
  name                         = lookup(var.edge_kubernetes[count.index], "name")
  version                      = lookup(var.edge_kubernetes[count.index], "version")
  security_group_id            = var.security_groups ? data.alicloud_security_groups.this.groups.0.id : element(alicloud_security_group.this.*.id, lookup(var.edge_kubernetes[count.index], "security_group_id"))
  is_enterprise_security_group = lookup(var.edge_kubernetes[count.index], "is_enterprise_security_group")
  rds_instances                = var.db_instances ? data.alicloud_db_instances.this.ids : element(alicloud_db_instance.this.*.id, lookup(var.edge_kubernetes[count.index], "db_instance_ids"))
  resource_group_id            = var.resource_groups ? data.alicloud_resource_manager_resource_groups.this.groups.0.id : element(alicloud_resource_manager_resource_group.this.*.id, lookup(var.edge_kubernetes[count.index], "resource_group_id"))
  deletion_protection          = lookup(var.edge_kubernetes[count.index], "deletion_protection")
  force_update                 = lookup(var.edge_kubernetes[count.index], "force_update")
  tags = merge(
    var.tags,
    lookup(var.edge_kubernetes[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  retain_resources               = lookup(var.edge_kubernetes[count.index], "retain_resources")
  cluster_spec                   = lookup(var.edge_kubernetes[count.index], "cluster_spec")
  runtime                        = lookup(var.edge_kubernetes[count.index], "runtime")
  availability_zone              = lookup(var.edge_kubernetes[count.index], "availability_zones")
  pod_cidr                       = lookup(var.edge_kubernetes[count.index], "pod_cidr")
  new_nat_gateway                = lookup(var.edge_kubernetes[count.index], "new_nat_gateway")
  service_cidr                   = lookup(var.edge_kubernetes[count.index], "service_cidr")
  node_cidr_mask                 = lookup(var.edge_kubernetes[count.index], "node_cidr_mask")
  slb_internet_enabled           = lookup(var.edge_kubernetes[count.index], "slb_internet_enabled")
  load_balancer_spec             = lookup(var.edge_kubernetes[count.index], "load_balancer_spec")
  password                       = sensitive(lookup(var.edge_kubernetes[count.index], "password"))
  key_name                       = lookup(var.edge_kubernetes[count.index], "key_name")
  worker_instance_charge_type    = lookup(var.edge_kubernetes[count.index], "worker_instance_charge_type")
  worker_disk_category           = lookup(var.edge_kubernetes[count.index], "worker_disk_category")
  worker_disk_size               = lookup(var.edge_kubernetes[count.index], "worker_disk_size")
  install_cloud_monitor          = lookup(var.edge_kubernetes[count.index], "install_cloud_monitor")
  proxy_mode                     = lookup(var.edge_kubernetes[count.index], "proxy_mode")
  user_data                      = lookup(var.edge_kubernetes[count.index], "user_data")
  worker_disk_performance_level  = lookup(var.edge_kubernetes[count.index], "worker_disk_performance_level")
  worker_disk_snapshot_policy_id = lookup(var.edge_kubernetes[count.index], "worker_disk_snapshot_policy_id")
  client_cert                    = file(join("/", [path.cwd, "certificate", lookup(var.edge_kubernetes[count.index], "client_cert")]))
  client_key                     = file(join("/", [path.cwd, "certificate", lookup(var.edge_kubernetes[count.index], "client_key")]))
  cluster_ca_cert                = file(join("/", [path.cwd, "certificate", lookup(var.edge_kubernetes[count.index], "cluster_ca_cert")]))

  dynamic "worker_data_disks" {
    for_each = lookup(var.edge_kubernetes[count.index], "worker_data_disks") == null ? [] : ["worker_data_disks"]
    content {
      category                = lookup(worker_data_disks.value, "category")
      size                    = lookup(worker_data_disks.value, "size")
      encrypted               = lookup(worker_data_disks.value, "encrypted")
      performance_level       = lookup(worker_data_disks.value, "performance_level")
      auto_snapshot_policy_id = lookup(worker_data_disks.value, "auto_snapshot_policy_id")
      snapshot_id             = lookup(worker_data_disks.value, "snapshot_id")
      kms_key_id              = lookup(worker_data_disks.value, "kms_key_id")
      name                    = lookup(worker_data_disks.value, "name")
      device                  = lookup(worker_data_disks.value, "device")
    }
  }

  dynamic "addons" {
    for_each = lookup(var.edge_kubernetes[count.index], "worker_data_disks") == null ? [] : ["worker_data_disks"]
    content {
      name     = lookup(addons.value, "name")
      config   = lookup(addons.value, "config")
      disabled = lookup(addons.value, "disabled")
    }
  }
}

resource "alicloud_cs_kubernetes_autoscaler" "this" {
  count = length(var.kubernetes_autoscaler) && var.managed_kubernetes != null || var.edge_kubernetes != null
  cluster_id = element(try(
    alicloud_cs_managed_kubernetes.this.*.id,
    alicloud_cs_serverless_kubernetes.this.*.id,
    alicloud_cs_edge_kubernetes.this.*.id
  ), lookup(var.kubernetes_autoscaler[count.index], "cluster_id"))
  cool_down_duration      = lookup(var.kubernetes_autoscaler[count.index], "cool_down_duration")
  defer_scale_in_duration = lookup(var.kubernetes_autoscaler[count.index], "defer_scale_in_duration")
  utilization             = lookup(var.kubernetes_autoscaler[count.index], "utilization")

  dynamic "nodepools" {
    for_each = lookup(var.kubernetes_autoscaler[count.index], "nodepools")
    content {
      id     = var.ess_scaling_configurations ? data.alicloud_ess_scaling_configurations.this.configurations.0.id : element(alicloud_ess_scaling_configuration.this.*.id, lookup(nodepools.value, "id"))
      labels = lookup(nodepools.value, "labels")
      taints = lookup(nodepools.value, "taints")
    }
  }
}

resource "alicloud_cs_kubernetes_node_pool" "this" {
  count = length(var.node_pool)
  cluster_id = element(try(
    alicloud_cs_edge_kubernetes.this.*.id,
    alicloud_cs_serverless_kubernetes.this.*.id,
    alicloud_cs_managed_kubernetes.this.*.id
  ), lookup(var.node_pool[count.index], "cluster_id"))
  instance_types                = [data.alicloud_instance_types.this.instance_types.0.id]
  name                          = lookup(var.node_pool[count.index], "name")
  vswitch_ids                   = var.vswitches ? data.alicloud_vswitches.this.vswitches : element(alicloud_vswitch.this.*.id, lookup(var.node_pool[count.index], "vswitch_ids"))
  password                      = sensitive(lookup(var.node_pool[count.index], "password"))
  key_name                      = lookup(var.node_pool[count.index], "key_name")
  desired_size                  = lookup(var.node_pool[count.index], "desired_state")
  system_disk_category          = lookup(var.node_pool[count.index], "system_disk_category")
  system_disk_size              = lookup(var.node_pool[count.index], "system_disk_size")
  system_disk_performance_level = lookup(var.node_pool[count.index], "system_disk_performance_level")
  scaling_policy                = lookup(var.node_pool[count.index], "scaling_policy")
  instance_charge_type          = lookup(var.node_pool[count.index], "instance_charge_type")
  period                        = lookup(var.node_pool[count.index], "period")
  period_unit                   = lookup(var.node_pool[count.index], "period_unit")
  auto_renew                    = lookup(var.node_pool[count.index], "auto_renew")
  auto_renew_period             = lookup(var.node_pool[count.index], "auto_renew_period")
  install_cloud_monitor         = lookup(var.node_pool[count.index], "install_cloud_monitor")
  unschedulable                 = lookup(var.node_pool[count.index], "unschedulable")
  resource_group_id             = var.resource_groups ? data.alicloud_resource_manager_resource_groups.this.groups.0.id : element(alicloud_resource_manager_resource_group.this.*.id, lookup(var.node_pool[count.index], "resource_group_id"))
  internet_charge_type          = lookup(var.node_pool[count.index], "internet_charge_type")
  internet_max_bandwidth_out    = lookup(var.node_pool[count.index], "internet_max_bandwidth_out")
  spot_strategy                 = lookup(var.node_pool[count.index], "spot_strategy")
  keep_instance_name            = lookup(var.node_pool[count.index], "keep_instance_name")
  format_disk                   = lookup(var.node_pool[count.index], "format_disk")
  image_type                    = lookup(var.node_pool[count.index], "image_type")
  runtime_name                  = lookup(var.node_pool[count.index], "runtime_name")
  runtime_version               = lookup(var.node_pool[count.index], "runtime_version")
  cis_enabled                   = lookup(var.node_pool[count.index], "cis_enabled")
  soc_enabled                   = lookup(var.node_pool[count.index], "soc_enabled")
  cpu_policy                    = lookup(var.node_pool[count.index], "cpu_policy")
  node_name_mode                = lookup(var.node_pool[count.index], "node_name_mode")
  user_data                     = lookup(var.node_pool[count.index], "user_data")
  tags = merge(
    var.tags,
    lookup(var.node_pool[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "data_disks" {
    for_each = lookup(var.node_pool[count.index], "data_disks") == null ? [] : ["data_disks"]
    content {
      category          = lookup(data_disks, "category")
      size              = lookup(data_disks, "size")
      encrypted         = lookup(data_disks, "encrypted")
      performance_level = lookup(data_disks, "performance_level")
      kms_key_id        = var.kms_keys ? data.alicloud_kms_keys.this.keys.0.id : element(alicloud_kms_key.this.*.id, lookup(data_disks, "kms_key_id"))
      device            = lookup(data_disks, "device")
      name              = lookup(data_disks, "name")
    }
  }

  dynamic "labels" {
    for_each = lookup(var.node_pool[count.index], "labels") == null ? [] : ["labels"]
    content {
      key   = lookup(labels.value, "key")
      value = lookup(labels.value, "value")
    }
  }
  dynamic "taints" {
    for_each = lookup(var.node_pool[count.index], "taints") == null ? [] : ["taints"]
    content {
      key    = lookup(taints.value, "key")
      value  = lookup(taints.value, "value")
      effect = lookup(taints.value, "effect")
    }
  }
  dynamic "management" {
    for_each = lookup(var.node_pool[count.index], "management") == null ? [] : ["management"]
    content {
      max_unavailable  = lookup(management.value, "max_unavailable")
      auto_repair      = lookup(management.value, "auto_repair")
      auto_upgrade     = lookup(management.value, "auto_upgrade")
      surge            = lookup(management.value, "surge")
      surge_percentage = lookup(management.value, "surge_percentage")
    }
  }

  dynamic "scaling_config" {
    for_each = lookup(var.node_pool[count.index], "scaling_config") == null ? [] : ["scaling_config"]
    content {
      max_size                 = lookup(scaling_config.value, "max_size")
      min_size                 = lookup(scaling_config.value, "min_size")
      type                     = lookup(scaling_config.value, "type")
      is_bond_eip              = lookup(scaling_config.value, "is_bond_eip")
      eip_internet_charge_type = lookup(scaling_config.value, "eip_internet_charge_type")
      eip_bandwidth            = lookup(scaling_config.value, "eip_bandwidth")
    }
  }

  dynamic "spot_price_limit" {
    for_each = lookup(var.node_pool[count.index], "spot_price_limit") == null ? [] : ["spot_price_limit"]
    content {
      instance_type = lookup(spot_price_limit.value, "instance_type")
      price_limit   = lookup(spot_price_limit.value, "price_limit")
    }
  }

  dynamic "kubelet_configuration" {
    for_each = lookup(var.node_pool[count.index], "kubelet_configuration") == null ? [] : ["kubelet_configuration"]
    content {
      registry_burst             = lookup(kubelet_configuration.value, "registry_burst")
      registry_pull_qps          = lookup(kubelet_configuration.value, "registry_pull_qps")
      event_record_qps           = lookup(kubelet_configuration.value, "event_record_qps")
      event_burst                = lookup(kubelet_configuration.value, "event_burst")
      kube_api_burst             = lookup(kubelet_configuration.value, "kube_api_burst")
      kube_api_qps               = lookup(kubelet_configuration.value, "kube_api_qps")
      kube_reserved              = lookup(kubelet_configuration.value, "kube_reserved")
      serialize_image_pulls      = lookup(kubelet_configuration.value, "serialize_image_pulls")
      cpu_manager_policy         = lookup(kubelet_configuration.value, "cpu_manager_policy")
      eviction_hard              = lookup(kubelet_configuration.value, "eviction_hard")
      eviction_soft              = lookup(kubelet_configuration.value, "eviction_soft")
      eviction_soft_grace_period = lookup(kubelet_configuration.value, "eviction_soft_grace_period")
      system_reserved            = lookup(kubelet_configuration.value, "system_reserved")
    }
  }

  dynamic "rolling_policy" {
    for_each = lookup(var.node_pool[count.index], "rolling_policy") == null ? [] : ["rolling_policy"]
    content {
      max_parallelism = lookup(rolling_policy.value, "max_parallelism")
    }
  }

  dynamic "rollout_policy" {
    for_each = lookup(var.node_pool[count.index], "rollout_policy") == null ? [] : ["rollout_policy"]
    content {
      max_unavailable = lookup(rollout_policy.value, "max_unavailable")
    }
  }
}

resource "alicloud_ram_user" "this" {
  count        = length(var.ram_user)
  name         = lookup(var.ram_user[count.index], "name")
  display_name = lookup(var.ram_user[count.index], "display_name")
}

resource "alicloud_ram_policy" "this" {
  count           = length(var.ram_policy)
  policy_name     = lookup(var.ram_policy[count.index], "policy_name")
  policy_document = lookup(var.ram_policy[count.index], "policy_document")
  description     = lookup(var.ram_policy[count.index], "description")
  force           = lookup(var.ram_policy[count.index], "force")
}

resource "alicloud_ram_user_policy_attachment" "this" {
  count       = length(var.policy_attachement)
  policy_name = element(alicloud_ram_policy.this.*.name, lookup(var.policy_attachement[count.index], "policy_id"))
  policy_type = element(alicloud_ram_policy.this.*.type, lookup(var.policy_attachement[count.index], "policy_id"))
  user_name   = element(alicloud_ram_user.this.*.name, lookup(var.policy_attachement[count.index], "user_id"))
}

resource "alicloud_cs_kubernetes_permissions" "this" {
  count = length(var.kubernetes_permission)
  uid   = element(alicloud_ram_user_policy_attachment.this.*.user_name, lookup(var.kubernetes_permission[count.index], "uuid"))

  dynamic "permissions" {
    for_each = lookup(var.kubernetes_permission[count.index], "permissions") == null ? [] : ["permissions"]
    content {
      cluster = element(try(
        alicloud_cs_managed_kubernetes.this.*.id,
        alicloud_cs_serverless_kubernetes.this.*.id,
        alicloud_cs_edge_kubernetes.this.*.id
      ), lookup(permissions.value, "cluster_id"))
      role_name   = lookup(permissions.value, "role_name")
      role_type   = lookup(permissions.value, "role_type")
      namespace   = lookup(permissions.value, "namespace")
      is_ram_role = lookup(permissions.value, "is_ram_role")
      is_custom   = lookup(permissions.value, "is_custom")
    }
  }
}

resource "alicloud_cs_serverless_kubernetes" "this" {
  count                          = length(var.serverless_kubernetes)
  vpc_id                         = var.vpcs ? data.alicloud_vpcs.this.vpcs.0.id : element(alicloud_vpc.this.*.id, lookup(var.serverless_kubernetes[count.index], "vpc_id"))
  name                           = lookup(var.serverless_kubernetes[count.index], "name")
  version                        = lookup(var.serverless_kubernetes[count.index], "version")
  vswitch_ids                    = var.vswitches ? data.alicloud_vswitches.this.ids : element(alicloud_vswitch.this.*.id, lookup(var.serverless_kubernetes[count.index], "vswitch_ids"))
  new_nat_gateway                = lookup(var.serverless_kubernetes[count.index], "new_nat_gateway")
  endpoint_public_access_enabled = lookup(var.serverless_kubernetes[count.index], "endpoint_public_access_enabled")
  service_discovery_types        = lookup(var.serverless_kubernetes[count.index], "service_discovery_types")
  deletion_protection            = lookup(var.serverless_kubernetes[count.index], "deletion_protection")
  enable_rrsa                    = lookup(var.serverless_kubernetes[count.index], "enable_rrsa")
  force_update                   = lookup(var.serverless_kubernetes[count.index], "force_update")
  tags                           = merge(
    var.tags,
    lookup(var.serverless_kubernetes[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  client_cert                    = lookup(var.serverless_kubernetes[count.index], "client_cert")
  client_key                     = lookup(var.serverless_kubernetes[count.index], "client_key")
  cluster_ca_cert                = lookup(var.serverless_kubernetes[count.index], "cluster_ca_cert")
  security_group_id              = var.security_groups ? data.alicloud_security_groups.this.groups.0.id : element(alicloud_security_group.this.*.id, lookup(var.serverless_kubernetes[count.index], "security_group_id"))
  resource_group_id              = var.resource_groups ? data.alicloud_resource_manager_resource_groups.this.groups.0.id : element(alicloud_resource_manager_resource_group.this.*.id, lookup(var.serverless_kubernetes[count.index], "resource_group_id"))
  load_balancer_spec             = lookup(var.serverless_kubernetes[count.index], "load_balancer_spec")
  time_zone                      = lookup(var.serverless_kubernetes[count.index], "time_zone")
  zone_id                        = data.alicloud_zones.this.zones[0].id
  service_cidr                   = lookup(var.serverless_kubernetes[count.index], "service_cidr")
  logging_type                   = lookup(var.serverless_kubernetes[count.index], "logging_type")
  sls_project_name               = lookup(var.serverless_kubernetes[count.index], "sls_project_name")
  retain_resources               = lookup(var.serverless_kubernetes[count.index], "retain_resources")
  cluster_spec                   = lookup(var.serverless_kubernetes[count.index], "cluster_spec")
  create_v2_cluster              = lookup(var.serverless_kubernetes[count.index], "create_v2_cluster")
  
  dynamic "addons" {
    for_each = lookup(var.serverless_kubernetes[count.index], "addons") == null ? [] : ["addons"]
    content {
      name     = lookup(addons.value, "name")
      config   = lookup(addons.value, "config")
      disabled = lookup(addons.value, "disabled")
    }
  }
}