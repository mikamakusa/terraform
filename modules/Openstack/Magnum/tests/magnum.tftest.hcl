run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "cluster_v1" {
  command = apply
  
  variables {
    project_name = "project_test"
    clustertemplate_v1 = [
      {
        id                    = 0
        name                  = "clustertemplate_1"
        image                 = "Fedora-Atomic-27"
        coe                   = "kubernetes"
        flavor                = "m1.small"
        master_flavor         = "m1.medium"
        dns_nameserver        = "1.1.1.1"
        docker_storage_driver = "devicemapper"
        docker_volume_size    = 10
        volume_driver         = "cinder"
        network_driver        = "flannel"
        server_type           = "vm"
        master_lb_enabled     = true
        floating_ip_enabled   = false
      }
    ]
    cluster_v1 = [
      {
        id = 0
        cluster_template_id = 0
        master_count        = 3
        node_count          = 5
        keypair             = "ssh_keypair"
      }
    ]
  }
}

run "clustertemplate_v1" {
  command = apply
  
  variables {
    project_name = "project_test"
    clustertemplate_v1 = [
      {
        id                    = 0
        name                  = "clustertemplate_1"
        image                 = "Fedora-Atomic-27"
        coe                   = "kubernetes"
        flavor                = "m1.small"
        master_flavor         = "m1.medium"
        dns_nameserver        = "1.1.1.1"
        docker_storage_driver = "devicemapper"
        docker_volume_size    = 10
        volume_driver         = "cinder"
        network_driver        = "flannel"
        server_type           = "vm"
        master_lb_enabled     = true
        floating_ip_enabled   = false
      }
    ]
  }
}

run "nodegroup_v1" {
  command = apply
  
  variables {
    project_name = "project_test"
    cluster_v1 = [
      {
        id = 0
        cluster_template_id = 0
        master_count        = 3
        node_count          = 5
        keypair             = "ssh_keypair"
      }
    ]
    nodegroup_v1 = [
      {
        id = 0
        name                = "nodegroup_1"
        cluster_id          = 0
        node_count          = 10
      }
    ]
  }
}
