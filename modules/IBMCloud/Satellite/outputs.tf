output "cluster" {
  value = try(
    ibm_satellite_cluster.this.*.id,
    ibm_satellite_cluster.this.*.location,
    ibm_satellite_cluster.this.*.crn,
    ibm_satellite_cluster.this.*.resource_group_name,
    ibm_satellite_cluster.this.*.name
  )
}

output "worker_pool" {
  value = try(
    ibm_satellite_cluster_worker_pool.this.*.name,
    ibm_satellite_cluster_worker_pool.this.*.id,
    ibm_satellite_cluster_worker_pool.this.*.cluster,
    ibm_satellite_cluster_worker_pool.this.*.worker_count
  )
}

output "location" {
  value = try(
    ibm_satellite_location.this.*.id,
    ibm_satellite_location.this.*.crn,
    ibm_satellite_location.this.*.location
  )
}

output "endpoint" {
  value = try(
    ibm_satellite_endpoint.this.*.id,
    ibm_satellite_endpoint.this.*.location,
    ibm_satellite_endpoint.this.*.crn,
    ibm_satellite_endpoint.this.*.endpoint_id
  )
}