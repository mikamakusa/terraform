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

resource "alicloud_threat_detection_instance" "this" {
  count                  = length(var.detection_instance)
  payment_type           = lookup(var.detection_instance[count.index], "payment_type")
  version_code           = lookup(var.detection_instance[count.index], "version_code")
  modify_type            = lookup(var.detection_instance[count.index], "modify_type")
  buy_number             = lookup(var.detection_instance[count.index], "buy_number")
  container_image_scan   = lookup(var.detection_instance[count.index], "container_image_scan")
  honeypot               = element(alicloud_threat_detection_honey_pot.this.*.honeypot_id, lookup(var.detection_instance[count.index], "honeypot_id"))
  honeypot_switch        = lookup(var.detection_instance[count.index], "honeypot_switch")
  period                 = lookup(var.detection_instance[count.index], "period")
  renew_period           = lookup(var.detection_instance[count.index], "renew_period")
  renewal_status         = lookup(var.detection_instance[count.index], "renewal_status")
  renewal_period_unit    = lookup(var.detection_instance[count.index], "renewal_period_unit")
  sas_anti_ransomware    = lookup(var.detection_instance[count.index], "sas_anti_ransomware")
  sas_sc                 = lookup(var.detection_instance[count.index], "sas_sc")
  sas_sdk                = lookup(var.detection_instance[count.index], "sas_sdk")
  sas_sdk_switch         = lookup(var.detection_instance[count.index], "sas_sdk_switch")
  sas_webguard_boolean   = lookup(var.detection_instance[count.index], "sas_webguard_boolean")
  sas_webguard_order_num = lookup(var.detection_instance[count.index], "sas_webguard_order_num")
  threat_analysis        = lookup(var.detection_instance[count.index], "threat_analysis")
  threat_analysis_switch = lookup(var.detection_instance[count.index], "threat_analysis_switch")
  v_core                 = lookup(var.detection_instance[count.index], "v_core")
}

resource "alicloud_threat_detection_anti_brute_force_rule" "this" {
  count                      = length(var.anti_brute_force_rule)
  anti_brute_force_rule_name = lookup(var.anti_brute_force_rule[count.index], "anti_brute_force_rule_name")
  fail_count                 = lookup(var.anti_brute_force_rule[count.index], "fail_count")
  forbidden_time             = lookup(var.anti_brute_force_rule[count.index], "forbidden_time")
  span                       = lookup(var.anti_brute_force_rule[count.index], "span")
  uuid_list                  = lookup(var.anti_brute_force_rule[count.index], "uuid_list")
}

resource "alicloud_threat_detection_backup_policy" "this" {
  count              = length(var.backup_policy)
  backup_policy_name = lookup(var.backup_policy[count.index], "backup_policy_name")
  policy             = lookup(var.backup_policy[count.index], "policy")
  policy_version     = lookup(var.backup_policy[count.index], "policy_version")
  uuid_list          = lookup(var.backup_policy[count.index], "uuid_list")
  policy_region_id   = lookup(var.backup_policy[count.index], "policy_region_id")
}

resource "alicloud_threat_detection_baseline_strategy" "this" {
  count                  = length(var.baseline_strategy)
  baseline_strategy_name = lookup(var.baseline_strategy[count.index], "baseline_strategy_name")
  custom_type            = lookup(var.baseline_strategy[count.index], "custom_type")
  cycle_days             = lookup(var.baseline_strategy[count.index], "cycle_days")
  end_time               = lookup(var.baseline_strategy[count.index], "end_time")
  risk_sub_type_name     = lookup(var.baseline_strategy[count.index], "risk_sub_type_name")
  start_time             = lookup(var.baseline_strategy[count.index], "start_time")
  target_type            = lookup(var.baseline_strategy[count.index], "target_type")
  cycle_start_time       = lookup(var.baseline_strategy[count.index], "cycle_start_time")
}

resource "alicloud_threat_detection_honeypot_node" "this" {
  count                          = length(var.honeypot_node)
  available_probe_num            = lookup(var.honeypot_node[count.index], "available_probe_num")
  node_name                      = lookup(var.honeypot_node[count.index], "node_name")
  allow_honeypot_access_internet = lookup(var.honeypot_node[count.index], "allow_honeypot_access_internet")
  security_group_probe_ip_list   = lookup(var.honeypot_node[count.index], "security_group_probe_ip_list")
}

resource "alicloud_threat_detection_honey_pot" "this" {
  count               = length(var.honey_pot)
  honeypot_image_id   = data.alicloud_threat_detection_honeypot_images.this.images.0.honeypot_image_id
  honeypot_image_name = data.alicloud_threat_detection_honeypot_images.this.images.0.honeypot_image_name
  honeypot_name       = lookup(var.honey_pot[count.index], "honeypot_name")
  node_id             = element(alicloud_threat_detection_honeypot_node.this.*.id, lookup(var.honey_pot[count.index], "node_id"))
}

resource "alicloud_threat_detection_honeypot_preset" "this" {
  count               = length(var.honeypot_preset)
  honeypot_image_name = data.alicloud_threat_detection_honeypot_images.this.images.0.honeypot_image_name
  node_id             = element(alicloud_threat_detection_honeypot_node.this.*.id, lookup(var.honeypot_preset[count.index], "node_id"))
  preset_name         = lookup(var.honeypot_preset[count.index], "preset_name")

  dynamic "meta" {
    for_each = lookup(var.honeypot_preset[count.index], "meta") == null ? [] : ["meta"]
    content {
      burp            = lookup(meta.value, "burp")
      portrait_option = lookup(meta.value, "portrait_option")
      trojan_git      = lookup(meta.value, "trojan_git")
    }
  }
}

resource "alicloud_threat_detection_honeypot_probe" "this" {
  count           = length(var.honeypot_probe)
  control_node_id = lookup(var.honeypot_probe[count.index], "control_node_id")
  display_name    = lookup(var.honeypot_probe[count.index], "display_name")
  probe_type      = lookup(var.honeypot_probe[count.index], "probe_type")
  arp             = lookup(var.honeypot_probe[count.index], "arp")
  ping            = lookup(var.honeypot_probe[count.index], "ping")
  proxy_ip        = lookup(var.honeypot_probe[count.index], "proxy_ip")
  probe_version   = lookup(var.honeypot_probe[count.index], "probe_version")
  service_ip_list = lookup(var.honeypot_probe[count.index], "service_ip_list")
  uuid            = lookup(var.honeypot_probe[count.index], "uuid")
  vpc_id          = var.vpcs ? data.alicloud_vpcs.this.vpcs.0.id : element(alicloud_vpc.this.*.id, lookup(var.honeypot_probe[count.index], "vpc_id"))
}

resource "alicloud_threat_detection_vul_whitelist" "this" {
  count       = length(var.vul_whitelist)
  whitelist   = lookup(var.vul_whitelist[count.index], "whitelist")
  target_info = lookup(var.vul_whitelist[count.index], "target_info")
  reason      = lookup(var.vul_whitelist[count.index], "reason")
}

resource "alicloud_threat_detection_web_lock_config" "this" {
  count               = length(var.web_lock_config)
  defence_mode        = lookup(var.web_lock_config[count.index], "defence_mode")
  dir                 = lookup(var.web_lock_config[count.index], "dir")
  local_backup_dir    = lookup(var.web_lock_config[count.index], "local_backup_dir")
  mode                = lookup(var.web_lock_config[count.index], "mode")
  uuid                = lookup(var.web_lock_config[count.index], "uuid")
  exclusive_dir       = lookup(var.web_lock_config[count.index], "exclusive_dir")
  exclusive_file      = lookup(var.web_lock_config[count.index], "exclusive_file")
  exclusive_file_type = lookup(var.web_lock_config[count.index], "exclusive_file_type")
  inclusive_file_type = lookup(var.web_lock_config[count.index], "inclusive_file_type")
}