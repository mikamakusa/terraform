output "redis_instance_hostname" {
  value = "${azurerm_redis_cache.redis_service.*.id}"
}

output "redis_instance_ssl_port" {
  value = "${azurerm_redis_cache.redis_service.*.ssl_port}"
}

output "reids_instance_port" {
  value = "${azurerm_redis_cache.redis_service.*.port}"
}

output "redis_instance_primary_access_key" {
  value = "${azurerm_redis_cache.redis_service.*.primary_access_key}"
}

output "redis_instance_secondary_access_key" {
  value = "${azurerm_redis_cache.redis_service.*.secondary_access_key}"
}

output "redis_firewall_name" {
  value = "${azurerm_redis_firewall_rule.redis_firewall.*.name}"
}

output "redis_firewall_start_ip" {
  value = "${azurerm_redis_firewall_rule.redis_firewall.*.start_ip}"
}

output "redis_firewall_end_ip" {
  value = "${azurerm_redis_firewall_rule.redis_firewall.*.end_ip}"
}