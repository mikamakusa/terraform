resource "openstack_containerinfra_cluster_v1" "this" {
  count               = length(var.cluster_v1) == "0" ? "0" : length(var.clustertemplate_v1)
  cluster_template_id = try(element(openstack_containerinfra_clustertemplate_v1.this.*.id, loookup(var.cluster_v1[count.index], "cluster_template_id")))
  region              = data.openstack_identity_project_v3.this.region
  project_id          = data.openstack_identity_project_v3.this.id
  name                = lookup(var.cluster_v1[count.index], "name")
  create_timeout      = lookup(var.cluster_v1[count.index], "create_timeout")
  discovery_url       = lookup(var.cluster_v1[count.index], "discovery_url")
  docker_volume_size  = lookup(var.cluster_v1[count.index], "docker_volume_size")
  flavor              = lookup(var.cluster_v1[count.index], "flavor")
  master_flavor       = lookup(var.cluster_v1[count.index], "master_flavor")
  keypair             = lookup(var.cluster_v1[count.index], "keypair")
  labels              = merge(
    var.labels,
    lookup(var.cluster_v1[count.index], "labels")
  )
  merge_labels        = lookup(var.cluster_v1[count.index], "merge_labels")
  master_count        = lookup(var.cluster_v1[count.index], "master_count")
  node_count          = lookup(var.cluster_v1[count.index], "node_count")
  fixed_network       = lookup(var.cluster_v1[count.index], "fixed_network")
  fixed_subnet        = lookup(var.cluster_v1[count.index], "fixed_subnet")
  floating_ip_enabled = lookup(var.cluster_v1[count.index], "floating_ip_enabled")
}

resource "openstack_containerinfra_clustertemplate_v1" "this" {
  count                 = length(var.clustertemplate_v1)
  coe                   = lookup(var.clustertemplate_v1[count.index], "coe")
  image                 = lookup(var.clustertemplate_v1[count.index], "image")
  name                  = lookup(var.clustertemplate_v1[count.index], "name")
  region                = data.openstack_identity_project_v3.this.region
  project_id            = data.openstack_identity_project_v3.this.id
  user_id               = lookup(var.clustertemplate_v1[count.index], "user_id")
  apiserver_port        = lookup(var.clustertemplate_v1[count.index], "apiserver_port")
  cluster_distro        = lookup(var.clustertemplate_v1[count.index], "cluster_distro")
  dns_nameserver        = lookup(var.clustertemplate_v1[count.index], "dns_nameserver")
  docker_storage_driver = lookup(var.clustertemplate_v1[count.index], "docker_storage_driver")
  docker_volume_size    = lookup(var.clustertemplate_v1[count.index], "docker_volume_size")
  external_network_id   = lookup(var.clustertemplate_v1[count.index], "external_network_id")
  fixed_network         = lookup(var.clustertemplate_v1[count.index], "fixed_network")
  fixed_subnet          = lookup(var.clustertemplate_v1[count.index], "fixed_subnet")
  flavor                = lookup(var.clustertemplate_v1[count.index], "flavor")
  master_flavor         = lookup(var.clustertemplate_v1[count.index], "master_flavor")
  floating_ip_enabled   = lookup(var.clustertemplate_v1[count.index], "floating_ip_enabled")
  http_proxy            = lookup(var.clustertemplate_v1[count.index], "http_proxy")
  https_proxy           = lookup(var.clustertemplate_v1[count.index], "https_proxy")
  insecure_registry     = lookup(var.clustertemplate_v1[count.index], "insecure_registry")
  keypair_id            = lookup(var.clustertemplate_v1[count.index], "keypair_id")
  labels                = merge(
    var.labels,
    lookup(var.clustertemplate_v1[count.index], "labels")
  )
  master_lb_enabled     = lookup(var.clustertemplate_v1[count.index], "master_lb_enabled")
  network_driver        = lookup(var.clustertemplate_v1[count.index], "network_driver")
  no_proxy              = lookup(var.clustertemplate_v1[count.index], "no_proxy")
  public                = lookup(var.clustertemplate_v1[count.index], "public")
  registry_enabled      = lookup(var.clustertemplate_v1[count.index], "registry_enabled")
  server_type           = lookup(var.clustertemplate_v1[count.index], "server_type")
  tls_disabled          = lookup(var.clustertemplate_v1[count.index], "tls_disabled")
  volume_driver         = lookup(var.clustertemplate_v1[count.index], "volume_driver")
  hidden                = lookup(var.clustertemplate_v1[count.index], "hidden")
}

resource "openstack_containerinfra_nodegroup_v1" "this" {
  count              = length(var.nodegroup_v1) == "0" ? "0" : length(var.cluster_v1)
  cluster_id         = try(element(openstack_containerinfra_cluster_v1.this.*.id, loookup(var.nodegroup_v1[count.index], "cluster_id")))
  name               = lookup(var.nodegroup_v1[count.index], "name")
  region             = data.openstack_identity_project_v3.this.region
  project_id         = data.openstack_identity_project_v3.this.id
  docker_volume_size = lookup(var.nodegroup_v1[count.index], "docker_volume_size")
  image_id           = lookup(var.nodegroup_v1[count.index], "image_id")
  flavor_id          = lookup(var.nodegroup_v1[count.index], "flavor_id")
  labels             = merge(
    var.labels,
    lookup(var.nodegroup_v1[count.index], "labels")
  )
  merge_labels       = lookup(var.nodegroup_v1[count.index], "merge_labels")
  node_count         = lookup(var.nodegroup_v1[count.index], "node_count")
  min_node_count     = lookup(var.nodegroup_v1[count.index], "min_node_count")
  max_node_count     = lookup(var.nodegroup_v1[count.index], "max_node_count")
  role               = lookup(var.nodegroup_v1[count.index], "role")
}