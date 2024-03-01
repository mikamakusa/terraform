## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.4 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_alloydb_backup.this](https://registry.terraform.io/providers/hashicorp/google/5.18.0/docs/resources/alloydb_backup) | resource |
| [google_alloydb_cluster.this](https://registry.terraform.io/providers/hashicorp/google/5.18.0/docs/resources/alloydb_cluster) | resource |
| [google_alloydb_instance.this](https://registry.terraform.io/providers/hashicorp/google/5.18.0/docs/resources/alloydb_instance) | resource |
| [google_alloydb_user.this](https://registry.terraform.io/providers/hashicorp/google/5.18.0/docs/resources/alloydb_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup"></a> [backup](#input\_backup) | An AlloyDB Backup. | <pre>list(map(object({<br>    id           = number<br>    backup_id    = string<br>    cluster_id   = number<br>    location     = string<br>    display_name = optional(string)<br>    labels       = optional(map(string))<br>    type         = optional(string)<br>    description  = optional(string)<br>    annotations  = optional(map(string))<br>    project      = optional(string)<br>    encryption_config = optional(list(object({<br>      kms_key_name = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | A managed alloydb cluster cluster. | <pre>list(map(object({<br>    id               = number<br>    cluster_id       = string<br>    location         = string<br>    labels           = optional(map(string))<br>    display_name     = optional(string)<br>    etag             = optional(string)<br>    annotations      = optional(map(string))<br>    database_version = optional(string)<br>    cluster_type     = optional(string)<br>    project          = optional(string)<br>    deletion_policy  = optional(string)<br>    encryption_config = optional(list(object({<br>      kms_key_name = optional(string)<br>    })), [])<br>    network_config = optional(list(object({<br>      network            = optional(string)<br>      allocated_ip_range = optional(string)<br>    })), [])<br>    initial_user = optional(list(object({<br>      password = string<br>      user     = optional(string)<br>    })), [])<br>    restore_backup_source = optional(list(object({<br>      backup_name = string<br>    })), [])<br>    restore_continuous_backup_source = optional(list(object({<br>      cluster       = string<br>      point_in_time = string<br>    })), [])<br>    continuous_backup_config = optional(list(object({<br>      enabled              = optional(bool)<br>      recovery_window_days = optional(number)<br>      encryption_config = optional(list(object({<br>        kms_key_name = optional(string)<br>      })), [])<br>    })), [])<br>    automated_backup_policy = optional(list(object({<br>      backup_window = optional(string)<br>      location      = optional(string)<br>      labels        = optional(map(string))<br>      enabled       = optional(bool)<br>      encryption_config = optional(list(object({<br>        kms_key_name = optional(string)<br>      })), [])<br>      weekly_schedule = optional(list(object({<br>        days_of_week = optional(list(string))<br>        start_times = optional(list(object({<br>          hours   = optional(number)<br>          minutes = optional(number)<br>          seconds = optional(number)<br>          nanos   = optional(number)<br>        })), [])<br>      })), [])<br>      time_based_retention = optional(list(object({<br>        retention_period = optional(string)<br>      })), [])<br>      quantity_based_retention = optional(list(object({<br>        count = optional(number)<br>      })), [])<br>    })), [])<br>    secondary_config = optional(list(object({<br>      primary_cluster_name = string<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | A managed alloydb cluster instance. | <pre>list(map(object({<br>    id                = number<br>    cluster_id        = number<br>    instance_id       = string<br>    instance_type     = string<br>    labels            = optional(map(string))<br>    annotations       = optional(map(string))<br>    display_name      = optional(string)<br>    gce_zone          = optional(string)<br>    database_flags    = optional(map(string))<br>    availability_type = optional(string)<br>    query_insights_config = optional(list(object({<br>      query_string_length     = optional(number)<br>      record_application_tags = optional(number)<br>      record_client_address   = optional(number)<br>      query_plans_per_minute  = optional(number)<br>    })), [])<br>    read_pool_config = optional(list(object({<br>      node_count = optional(number)<br>    })), [])<br>    machine_config = optional(list(object({<br>      cpu_count = optional(number)<br>    })), [])<br>    client_connection_config = optional(list(object({<br>      require_connectors = optional(bool)<br>      ssl_config = optional(list(object({<br>        ssl_mode = optional(string)<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | A database user in an AlloyDB cluster. | <pre>list(map(object({<br>    id             = number<br>    cluster_id     = number<br>    user_id        = string<br>    user_type      = string<br>    password       = optional(string)<br>    database_roles = optional(list(string))<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup"></a> [backup](#output\_backup) | n/a |
| <a name="output_cluster"></a> [cluster](#output\_cluster) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_user"></a> [user](#output\_user) | n/a |
