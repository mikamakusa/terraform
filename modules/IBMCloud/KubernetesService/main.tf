resource "ibm_container_cluster" "this" {
  count = length(var.cluster)
  datacenter = ""
  hardware   = ""
  name       = ""
  default_pool_size = 0
  disk_encryption = true
  entitlement = ""
  force_delete_storage = true
  image_security_enforcement = true
  gateway_enabled = true
  kube_version = ""
  labels = {}
  machine_type = ""
  no_subnet = true
  operating_system = ""
  patch_version = ""
  public_service_endpoint = true
  public_vlan_id = ""
  private_service_endpoint = true
  private_vlan_id = ""
  pod_subnet = ""
  resource_group_id = ""
  retry_patch_version = true
  subnet_id = []
  service_subnet = ""
  tags = []
  update_all_workers = true
  wait_for_worker_update = true
  wait_till = ""

  dynamic "workers_info" {
    for_each = ""
    content {
      id = ""
      version = ""
    }
  }

  dynamic "webhook" {
    for_each = ""
    content {
      level = ""
      type  = ""
      url   = ""
    }
  }

  dynamic "taints" {
    for_each = ""
    content {
      effect = ""
      key    = ""
      value  = ""
    }
  }

  dynamic "kms_config" {
    for_each = ""
    content {
      crk_id      = ""
      instance_id = ""
      private_endpoint = true
    }
  }
}

resource "ibm_container_alb_create" "this" {
  count = length(var.alb_create)
  alb_type = ""
  cluster  = ""
  vlan_id  = ""
  zone     = ""
}

resource "ibm_container_alb" "this" {
  count = length(var.alb)
  alb_id = ""
}

resource "ibm_container_alb_cert" "this" {
  count = length(var.alb_cert)
  cert_crn    = ""
  cluster_id  = ""
  secret_name = ""
}

resource "ibm_container_addons" "this" {
  count = length(var.addons)
  cluster = ""
  manage_all_addons = true
  resource_group_id = ""

  dynamic "addons" {
    for_each = ""
    content {
      name = ""
      version = ""
      parameters_json = ""
    }
  }
}

resource "ibm_container_api_key_reset" "this" {
  count = length(var.api_key_reset)
  region = ""
}

resource "ibm_container_bind_service" "this" {
  count = length(var.bind_service)
  cluster_name_id = ""
  namespace_id    = ""
}

resource "ibm_container_cluster_feature" "this" {
  count = length(var.cluster_feature)
  cluster = ""
}

resource "ibm_container_dedicated_host" "this" {
  count = length(var.dedicated_host)
  flavor       = ""
  host_pool_id = ""
  zone         = ""
}

resource "ibm_container_dedicated_host_pool" "this" {
  count = length(var.dedicated_host_pool)
  flavor_class = ""
  metro        = ""
  name         = ""
}

resource "ibm_container_ingress_instance" "this" {
  count = length(var.ingress_instance)
  cluster      = ""
  instance_crn = ""
}

resource "ibm_container_nlb_dns" "this" {
  count = length(var.nlb_dns)
  cluster  = ""
  nlb_host = ""
  nlb_ips  = []
}

resource "ibm_container_storage_attachment" "this" {
  count = length(var.storage_attachment)
  cluster = ""
  volume  = ""
  worker  = ""
}

resource "ibm_container_vpc_alb_create" "this" {
  count = length(var.vpc_alb_create)
  cluster = ""
  type    = ""
  zone    = ""
}

resource "ibm_container_vpc_alb" "this" {
  count = length(var.vpc_alb)
  alb_id = ""
}

resource "ibm_container_vpc_cluster" "this" {
  count = length(var.vpc_cluster)
  flavor = ""
  name   = ""
  vpc_id = ""
}

resource "ibm_container_vpc_worker" "this" {
  count = length(var.vpc_worker)
  cluster_name   = ""
  replace_worker = ""
}

resource "ibm_container_vpc_worker_pool" "this" {
  count = length(var.vpc_worker_pool)
  cluster          = ""
  flavor           = ""
  vpc_id           = ""
  worker_count     = 0
  worker_pool_name = ""
}

resource "ibm_container_worker_pool" "this" {
  count = length(var.worker_pool)
  cluster          = ""
  machine_type     = ""
  size_per_zone    = 0
  worker_pool_name = ""
}

resource "ibm_container_worker_pool_zone_attachment" "this" {
  count = length(var.worker_pool_zone_attachment)
  cluster     = ""
  worker_pool = ""
  zone        = ""
}

resource "ibm_ob_logging" "this" {
  count = length(var.ob_logging)
  cluster     = ""
  instance_id = ""
}

resource "ibm_ob_monitoring" "this" {
  count = length(var.ob_monitoring)
  cluster     = ""
  instance_id = ""
}