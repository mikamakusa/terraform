output "agent" {
  value = try(oci_cloud_bridge_agent.this,oci_cloud_bridge_agent_plugin.this,oci_cloud_bridge_agent_dependency.this)
}

output "asset" {
  value = try(oci_cloud_bridge_asset.this,oci_cloud_bridge_asset_source.this)
}

output "environment" {
  value = try(oci_cloud_bridge_environment.this)
}

output "inventory" {
  value = try(oci_cloud_bridge_inventory.this)
}

output "discovery_schedule" {
  value = try(oci_cloud_bridge_discovery_schedule.this)
}