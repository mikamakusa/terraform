output "cluster" {
  value = try(
    openstack_containerinfra_cluster_v1.this.*.id,
    openstack_containerinfra_cluster_v1.this.*.name,
    openstack_containerinfra_cluster_v1.this.*.cluster_template_id,
    openstack_containerinfra_cluster_v1.this.*.container_version
  )
}

output "clustertemplate" {
  value = try(
    openstack_containerinfra_clustertemplate_v1.this.*.id,
    openstack_containerinfra_clustertemplate_v1.this.*.name,
    openstack_containerinfra_clustertemplate_v1.this.*.apiserver_port,
    openstack_containerinfra_clustertemplate_v1.this.*.cluster_distro,
    openstack_containerinfra_clustertemplate_v1.this.*.dns_nameserver,
    openstack_containerinfra_clustertemplate_v1.this.*.docker_storage_driver
  )
}

output "nodegroup" {
  value = try(
    openstack_containerinfra_nodegroup_v1.this.*.name,
    openstack_containerinfra_nodegroup_v1.this.*.id,
    openstack_containerinfra_nodegroup_v1.this.*.flavor_id,
    openstack_containerinfra_nodegroup_v1.this.*.image_id,
    openstack_containerinfra_nodegroup_v1.this.*.cluster_id
  )
}