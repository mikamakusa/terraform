output "instance" {
  value = try(
    openstack_compute_instance_v2.this.*.id,
    openstack_compute_instance_v2.this.*.name,
    openstack_compute_instance_v2.this.*.access_ip_v4,
    openstack_compute_instance_v2.this.*.access_ip_v6,
    openstack_compute_instance_v2.this.*.admin_pass,
    openstack_compute_instance_v2.this.*.all_metadata,
    openstack_compute_instance_v2.this.*.all_tags,
    openstack_compute_instance_v2.this.*.volume,
    openstack_compute_instance_v2.this.*.network,
    openstack_compute_instance_v2.this.*.image_id,
    openstack_compute_instance_v2.this.*.user_data
  )
}

output "flavor" {
  value = try(
    openstack_compute_flavor_v2.this.*.name,
    openstack_compute_flavor_v2.this.*.disk,
    openstack_compute_flavor_v2.this.*.ephemeral,
    openstack_compute_flavor_v2.this.*.vcpus,
    openstack_compute_flavor_v2.this.*.swap,
    openstack_compute_flavor_v2.this.*.ram,
    openstack_compute_flavor_v2.this.*.flavor_id
  )
}

output "volume_attach" {
  value = try(
    openstack_compute_volume_attach_v2.this.*.id,
    openstack_compute_volume_attach_v2.this.*.instance_id
  )
}

output "servergroup" {
  value = try(
    openstack_compute_servergroup_v2.this.*.id,
    openstack_compute_servergroup_v2.this.*.policies,
    openstack_compute_servergroup_v2.this.*.value_specs,
    openstack_compute_servergroup_v2.this.*.rules,
    openstack_compute_servergroup_v2.this.*.members,
    openstack_compute_servergroup_v2.this.*.name
  )
}

output "quotaset" {
  value = try(
    openstack_compute_quotaset_v2.this.*.id,
    openstack_compute_quotaset_v2.this.*.ram,
    openstack_compute_quotaset_v2.this.*.cores,
    openstack_compute_quotaset_v2.this.*.fixed_ips,
    openstack_compute_quotaset_v2.this.*.floating_ips,
    openstack_compute_quotaset_v2.this.*.injected_file_content_bytes,
    openstack_compute_quotaset_v2.this.*.injected_file_path_bytes,
    openstack_compute_quotaset_v2.this.*.injected_files,
    openstack_compute_quotaset_v2.this.*.instances,
    openstack_compute_quotaset_v2.this.*.key_pairs
  )
}

output "keypair" {
  value = try(
    openstack_compute_keypair_v2.this.*.id,
    openstack_compute_keypair_v2.this.*.private_key,
    openstack_compute_keypair_v2.this.*.public_key,
    openstack_compute_keypair_v2.this.*.fingerprint
  )
}

output "aggregate" {
  value = try(
    openstack_compute_aggregate_v2.this.*.id,
    openstack_compute_aggregate_v2.this.*.name,
    openstack_compute_aggregate_v2.this.*.hosts
  )
}