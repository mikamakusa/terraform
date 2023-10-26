output "vpc" {
  value = try(
    data.alicloud_vpcs.this,
    alicloud_vpc.this
  )
}

output "detection_instance" {
  value = try(
    alicloud_threat_detection_instance.this
  )
}

output "anti_brute_force_rule" {
  value = try(
    alicloud_threat_detection_anti_brute_force_rule.this
  )
}

output "backup_policy" {
  value = try(
    alicloud_threat_detection_backup_policy.this
  )
}

output "baseline_strategy" {
  value = try(
    alicloud_threat_detection_baseline_strategy.this
  )
}

output "honeypot" {
  value = try(
    alicloud_threat_detection_honey_pot.this,
    alicloud_threat_detection_honeypot_node.this,
    alicloud_threat_detection_honeypot_probe.this,
    alicloud_threat_detection_honeypot_preset.this
  )
}

output "vul_whitelist" {
  value = try(
    alicloud_threat_detection_vul_whitelist.this
  )
}

output "web_lock_config" {
  value = try(
    alicloud_threat_detection_web_lock_config.this
  )
}