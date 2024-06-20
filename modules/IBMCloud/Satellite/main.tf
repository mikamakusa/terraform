resource "ibm_satellite_cluster" "this" {
  count                           = length(var.location) == 0 ? 0 : length(var.cluster)
  location                        = try(element(ibm_satellite_location.this.*.id, lookup(var.cluster[count.index], "location_id")))
  name                            = lookup(var.cluster[count.index], "name")
  crn_token                       = try(lookup(var.cluster[count.index], "crn_token"))
  default_worker_pool_labels      = try(lookup(var.cluster[count.index], "default_worker_pool_labels"))
  disable_public_service_endpoint = try(lookup(var.cluster[count.index], "disable_public_service_endpoint"))
  enable_config_admin             = try(lookup(var.cluster[count.index], "enable_config_admin"))
  host_labels                     = try(lookup(var.cluster[count.index], "host_labels"))
  infrastructure_topology         = try(lookup(var.cluster[count.index], "infrastructure_topology"))
  kube_version                    = try(lookup(var.cluster[count.index], "kube_version"))
  operating_system                = try(lookup(var.cluster[count.index], "operating_system"))
  patch_version                   = try(lookup(var.cluster[count.index], "patch_version"))
  pod_subnet                      = try(lookup(var.cluster[count.index], "pod_subnet"))
  pull_secret                     = try(lookup(var.cluster[count.index], "pull_secret"))
  resource_group_id               = try(data.ibm_resource_group.this.id)
  retry_patch_version             = try(lookup(var.cluster[count.index], "retry_patch_version"))
  service_subnet                  = try(lookup(var.cluster[count.index], "service_subnet"))
  tags                            = try(lookup(var.cluster[count.index], "tags"))
  wait_for_worker_update          = try(lookup(var.cluster[count.index], "wait_for_worker_update"))
  worker_count                    = try(lookup(var.cluster[count.index], "worker_count"))

  dynamic "zones" {
    for_each = try(lookup(var.cluster[count.index], "zones")) == null ? [] : ["zones"]
    content {
      id = lookup(zones.value, "id")
    }
  }
}

resource "ibm_satellite_cluster_worker_pool" "this" {
  count              = length(var.cluster) == 0 ? 0 : length(var.cluster_worker_pool)
  cluster            = try(element(ibm_satellite_location.this.*.id, lookup(var.cluster_worker_pool[count.index], "location_id")))
  name               = try(lookup(var.cluster_worker_pool[count.index], "name"))
  disk_encryption    = try(lookup(var.cluster_worker_pool[count.index], "disk_encryption"))
  entitlement        = try(lookup(var.cluster_worker_pool[count.index], "entitlement"))
  flavor             = try(lookup(var.cluster_worker_pool[count.index], "flavor"))
  host_labels        = try(lookup(var.cluster_worker_pool[count.index], "host_labels"))
  isolation          = try(lookup(var.cluster_worker_pool[count.index], "isolation"))
  operating_system   = try(lookup(var.cluster_worker_pool[count.index], "operating_system"))
  resource_group_id  = try(data.ibm_resource_group.this.id)
  worker_count       = try(lookup(var.cluster_worker_pool[count.index], "worker_count"))
  worker_pool_labels = try(lookup(var.cluster_worker_pool[count.index], "worker_pool_labels"))

  dynamic "zones" {
    for_each = try(lookup(var.cluster_worker_pool[count.index], "zones")) == null ? [] : ["zones"]
    content {
      id = lookup(zones.value, "id")
    }
  }
}

resource "ibm_satellite_cluster_worker_pool_zone_attachment" "this" {
  count             = (length(var.cluster) && length(var.cluster_worker_pool)) == 0 ? 0 : length(var.cluster_worker_pool_zone_attachment)
  cluster           = try(element(ibm_satellite_cluster.this.*.id, lookup(var.cluster_worker_pool_zone_attachment[count.index], "cluster_id")))
  worker_pool       = try(element(ibm_satellite_cluster_worker_pool.this.*.id, lookup(var.cluster_worker_pool_zone_attachment[count.index], "worker_pool")))
  zone              = lookup(var.cluster_worker_pool_zone_attachment[count.index], "zone")
  resource_group_id = try(data.ibm_resource_group.this.id)
}

resource "ibm_satellite_endpoint" "this" {
  count              = length(var.location) == 0 ? 0 : length(var.endpoint)
  client_protocol    = try(lookup(var.endpoint[count.index], "client_protocol"))
  connection_type    = try(lookup(var.endpoint[count.index], "connection_type"))
  display_name       = try(lookup(var.endpoint[count.index], "display_name"))
  location           = try(element(ibm_satellite_location.this.*.id, lookup(var.endpoint[count.index], "location_id")))
  server_host        = try(lookup(var.endpoint[count.index], "server_host"))
  server_port        = try(lookup(var.endpoint[count.index], "server_port"))
  client_mutual_auth = try(lookup(var.endpoint[count.index], "client_mutual_auth"))
  created_by         = try(lookup(var.endpoint[count.index], "created_by"))
  server_mutual_auth = try(lookup(var.endpoint[count.index], "server_mutual_auth"))
  server_protocol    = try(lookup(var.endpoint[count.index], "server_protocol"))
  sni                = try(lookup(var.endpoint[count.index], "sni"))
  timeout            = try(lookup(var.endpoint[count.index], "timeout"))

  /*dynamic "certs" {
    for_each = ""
    content {
      dynamic "client" {
        for_each = ""
        content {}
      }
      dynamic "connector" {
        for_each = ""
        content {}
      }
      dynamic "server" {
        for_each = ""
        content {}
      }
    }
  }*/
}

resource "ibm_satellite_host" "this" {
  count         = length(var.location) == 0 ? 0 : length(var.host)
  host_id       = lookup(var.host[count.index], "host_id")
  location      = try(element(ibm_satellite_location.this.*.id, lookup(var.host[count.index], "location_id")))
  host_provider = try(lookup(var.host[count.index], "host_provider"))
  labels        = try(lookup(var.host[count.index], "labels"))
  worker_pool   = try(element(ibm_satellite_cluster_worker_pool.this.*.id, lookup(var.host[count.index], "worker_pool_id")))
}

resource "ibm_satellite_link" "this" {
  count    = length(var.location) == 0 ? 0 : length(var.link)
  crn      = try(element(ibm_satellite_location.this.*.crn, lookup(var.link[count.index], "location_id")))
  location = try(element(ibm_satellite_location.this.*.id, lookup(var.link[count.index], "location_id")))
}

resource "ibm_satellite_location" "this" {
  count              = length(var.location)
  location           = lookup(var.location[count.index], "location")
  managed_from       = lookup(var.location[count.index], "managed_from")
  resource_group_id  = data.ibm_resource_group.this.id
  zones              = lookup(var.location[count.index], "zones")
  coreos_enabled     = lookup(var.location[count.index], "coreos_enabled")
  description        = lookup(var.location[count.index], "description")
  logging_account_id = lookup(var.location[count.index], "logging_account_id")
  pod_subnet         = lookup(var.location[count.index], "pod_subnet")
  service_subnet     = lookup(var.location[count.index], "service_subnet")

  dynamic "cos_config" {
    for_each = lookup(var.location[count.index], "cos_config") == null ? [] : ["cos_config"]
    content {
      bucket   = try(data.ibm_cos_bucket.this.bucket_name)
      endpoint = try(lookup(cos_config.value, "endpoint"))
      region   = try(lookup(cos_config.value, "region"))
    }
  }

  dynamic "cos_credentials" {
    for_each = lookup(var.location[count.index], "cos_credentials") == null ? [] : ["cos_credentials"]
    content {
      access_key_id     = try(sensitive(lookup(cos_credentials.value, "access_key_id")))
      secret_access_key = try(sensitive(lookup(cos_credentials.value, "secret_access_key")))
    }
  }
}

resource "ibm_satellite_location_nlb_dns" "this" {
  count    = length(var.location) == 0 ? 0 : length(var.location_nlb_dns)
  ips      = lookup(var.location_nlb_dns[count.index], "ips")
  location = try(element(ibm_satellite_location.this.*.id, lookup(var.location_nlb_dns[count.index], "location_id")))
}

resource "ibm_satellite_storage_assignment" "this" {
  count                  = length(var.storage_configuration) == 0 ? 0 : length(var.storage_assignment)
  assignment_name        = lookup(var.storage_assignment[count.index], "assignment_name")
  config                 = try(element(ibm_satellite_storage_configuration.this.*.config_name, lookup(var.storage_assignment[count.index], "config_id")))
  cluster                = try(element(ibm_satellite_cluster.this.*.id, lookup(var.storage_assignment[count.index], "cluster_id")))
  controller             = try(element(ibm_satellite_storage_configuration.this.*.location, lookup(var.storage_assignment[count.index], "config_id")))
  groups                 = try(lookup(var.storage_assignment[count.index], "groups"))
  update_config_revision = try(lookup(var.storage_assignment[count.index], "update_config_revision"))
}

resource "ibm_satellite_storage_configuration" "this" {
  count                    = length(var.location) == 0 ? 0 : length(var.storage_configuration)
  config_name              = lookup(var.storage_configuration[count.index], "config_name")
  location                 = try(element(ibm_satellite_location.this.*.id, lookup(var.storage_configuration[count.index], "location_id")))
  storage_template_name    = lookup(var.storage_configuration[count.index], "storage_template_name")
  storage_template_version = lookup(var.storage_configuration[count.index], "storage_template_version")
  user_config_parameters   = lookup(var.storage_configuration[count.index], "user_config_parameters")
  user_secret_parameters   = lookup(var.storage_configuration[count.index], "user_secret_parameters")
  delete_assignments       = try(lookup(var.storage_configuration[count.index], "delete_assignments"))
  storage_class_parameters = try(lookup(var.storage_configuration[count.index], "storage_class_parameters"))
  update_assignments       = try(lookup(var.storage_configuration[count.index], "update_assignments"))
}