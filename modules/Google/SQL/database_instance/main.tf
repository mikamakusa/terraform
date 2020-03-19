resource "google_sql_database_instance" "instance" {
  count                = length(var.instance)
  name                 = lookup(var.instance[count.index], "name")
  database_version     = lookup(var.instance[count.index], "database_version")
  region               = lookup(var.instance[count.index], "region")
  master_instance_name = lookup(var.instance[count.index], "master_instance_name")
  project              = var.project
  provider             = "google-beta"

  dynamic "settings" {
    for_each = [for setting in lookup(var.instance[count.index], "settings") : {
      tier                 = setting.tier
      activation_policy    = setting.activation_policy
      availability_type    = setting.availability_type
      disk_autoresize      = setting.disk_autoresize
      disk_size            = setting.disk_size
      disk_type            = setting.disk_type
      pricing_plan         = setting.pricing_plan
      replication_type     = setting.replication_type
      user_labels          = lookup(setting, "user_label", null)
      database_flags       = lookup(setting, "database_flags", null)
      backup_configuration = lookup(setting, "backup_configuration", null)
      ip_configuration     = lookup(setting, "ip_configuration", null)
      location_preference  = lookup(setting, "location_preference", null)
      maintenance_window   = lookup(setting, "maintenance_window", null)
    }]
    content {
      tier              = settings.value.tier
      activation_policy = settings.value.activation_policy
      availability_type = settings.value.availability_type
      disk_autoresize   = settings.value.disk_autoresize
      disk_size         = settings.value.disk_size
      disk_type         = settings.value.disk_type
      pricing_plan      = settings.value.pricing_plan
      replication_type  = settings.value.replication_type

      user_labels {
        variables = settings.value.user_labels
      }

      dynamic "database_flags" {
        for_each = settings.value.database_flags == null ? [] : [for flag in settings.value.database_flags : {
          name  = flag.name
          value = flag.value
        }]
        content {
          name  = database_flags.value.name
          value = database_flags.value.value
        }
      }

      dynamic "backup_configuration" {
        for_each = settings.value.backup_configuration == null ? [] : [for config in settings.value.backup_configuration : {
          binary_log_enabled = config.binary_log_enabled
          enabled            = config.enabled
          start_time         = config.start_time
        }]
        content {
          binary_log_enabled = backup_configuration.value.binary_log_enabled
          enabled            = backup_configuration.value.enabled
          start_time         = backup_configuration.value.start_time
        }
      }

      dynamic "ip_configuration" {
        for_each = settings.value.ip_configuration == null ? [] : [for ip in settings.value.ip_configuration : {
          ipv4                = ip.ipv4_enabled
          private_network     = ip.private_network
          require_ssl         = ip.require_ssl
          authorized_networks = lookup(ip, "authorized_networks", null)
        }]
        content {
          ipv4_enabled    = ip_configuration.value.ipv4
          private_network = ip_configuration.value.private_network
          require_ssl     = ip_configuration.value.require_ssl
          dynamic "authorized_networks" {
            for_each = ip_configuration.value.authorized_networks == null ? [] : [for net in ip_configuration.value.authorized_networks : {
              expiration_time = net.expiration_time
              name            = net.name
              value           = net.value
            }]
            content {
              expiration_time = authorized_networks.value.expiration_time
              name            = authorized_networks.value.name
              value           = authorized_networks.value.value
            }
          }
        }
      }

      dynamic "location_preference" {
        for_each = settings.value.location_preference == null ? [] : [for location in settings.value.location_preference : {
          follow_gae_application = location.follow_gae_application
          zone                   = location.zone
        }]
        content {
          follow_gae_application = location_preference.value.follow_gae_application
          zone                   = location_preference.value.zone
        }
      }

      dynamic "maintenance_window" {
        for_each = settings.value.maintenance_window == null ? [] : [for main in settings.value.maintenance_window : {
          day          = main.day
          hour         = main.hour
          update_track = main.update_track
        }]
        content {
          day          = maintenance_window.value.day
          hour         = maintenance_window.value.hour
          update_track = maintenance_window.value.update_track
        }
      }
    }
  }

  dynamic "replica_configuration" {
    for_each = lookup(var.instance[count.index], "replica_configuration")
    content {
      ca_certificate            = lookup(replica_configuration.value, "ca_certificate")
      client_certificate        = lookup(replica_configuration.value, "client_certificate")
      client_key                = lookup(replica_configuration.value, "client_key")
      connect_retry_interval    = lookup(replica_configuration.value, "connect_retry_interval")
      dump_file_path            = lookup(replica_configuration.value, "dump_file_path")
      failover_target           = lookup(replica_configuration.value, "failover_target")
      master_heartbeat_period   = lookup(replica_configuration.value, "master_heartbeat_period")
      password                  = base64decode(lookup(replica_configuration.value, "password"))
      username                  = lookup(replica_configuration.value, "username")
      ssl_cipher                = lookup(replica_configuration.value, "ssl_cipher")
      verify_server_certificate = lookup(replica_configuration.value, "verify_server_certificate")
    }
  }
}