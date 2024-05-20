run "app" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    app = [
      {
        id     = 0
        spec   = [
          {
            name   = "golang-sample"
            vpc_id     = 0
            service = [
              {
                name               = "go-service"
                environment_slug   = "go"
                instance_count     = 1
                instance_size_slug = "professional-xs"
                git = [
                  {
                    repo_clone_url = "https://github.com/digitalocean/sample-golang.git"
                    branch         = "main"
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  }
}

run "cdn" {
  command = apply

  variables {
    cdn = [{
      id = 0
    }]
  }
}

run "certificate" {
  command = apply

  variables {
    certificate = [{
      id                = 0
      name              = "custom-terraform-example"
      type              = "custom"
      private_key       = file("/Users/terraform/certs/privkey.pem")
      leaf_certificate  = file("/Users/terraform/certs/cert.pem")
      certificate_chain = file("/Users/terraform/certs/fullchain.pem")
    }]
  }
}

run "container_registry" {
  command = apply

  variables {
    container_registry = [{
      id                     = 0
      name                   = "foobar"
      subscription_tier_slug = "starter"
    }]
  }
}

run "container_registry_docker_credentials" {
  command = apply

  variables {
    container_registry = [
      {
      id                     = 0
      name                   = "foobar"
      subscription_tier_slug = "starter"
      }
    ]
    container_registry_docker_credentials = [
      {
        id          = 0
        registry_id = 0
      }
    ]
  }
}

run "custom_image" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    custom_image = [
      {
        id      = 0
        name    = "flatcar"
        url     = "https://stable.release.flatcar-linux.net/amd64-usr/2605.7.0/flatcar_production_digitalocean_image.bin.bz2"
        vpc_id  = 0
      }
    ]
  }
}

run "database_cluster" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-postgres-cluster"
        engine     = "pg"
        version    = "15"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
        node_count = 1
      }
    ]
  }
}

run "database_connection_pool" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-postgres-cluster"
        engine     = "pg"
        version    = "15"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
        node_count = 1
      }
    ]
    database_connection_pool = [
      {
        id         = 0
        cluster_id = 0
        name       = "pool-01"
        mode       = "transaction"
        size       = 20
        db_name    = "defaultdb"
        user       = "doadmin"
      }
    ]
  }
}

run "database_db" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-postgres-cluster"
        engine     = "pg"
        version    = "15"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
        node_count = 1
      }
    ]
    database_db = [
      {
        id         = 0
        cluster_id = 0
        name       = "foobar"
      }
    ]
  }
}

run "database_firewall" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-postgres-cluster"
        engine     = "pg"
        version    = "15"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
        node_count = 1
      }
    ]
    database_firewall = [
      {
        id         = 0
        cluster_id = digitalocean_database_cluster.postgres-example.id
        rule = [
          {
            type  = "ip_addr"
            value = "192.168.1.1"
          }
        ]
        rule = [
          {
            type  = "ip_addr"
            value = "192.0.2.0"
          }
        ]
      }
    ]
  }
}
run "database_kafka_topic" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-kafka-cluster"
        engine     = "kafka"
        version    = "3.5"
        size       = "db-s-2vcpu-2gb"
        vpc_id     = 0
        node_count = 3
        tags       = ["production"]
      }
    ]
    database_kafka_topic = [
      {
        id                 = 0
        name               = "topic-01"
        partition_count    = 3
        replication_factor = 2
        config = [{
          cleanup_policy                      = "compact"
          compression_type                    = "uncompressed"
          delete_retention_ms                 = 14000
          file_delete_delay_ms                = 170000
          flush_messages                      = 92233
          flush_ms                            = 92233720368
          index_interval_bytes                = 40962
          max_compaction_lag_ms               = 9223372036854775807
          max_message_bytes                   = 1048588
          message_down_conversion_enable      = true
          message_format_version              = "3.0-IV1"
          message_timestamp_difference_max_ms = 9223372036854775807
          message_timestamp_type              = "log_append_time"
          min_cleanable_dirty_ratio           = 0.5
          min_compaction_lag_ms               = 20000
          min_insync_replicas                 = 2
          preallocate                         = false
          retention_bytes                     = -1
          retention_ms                        = -1
          segment_bytes                       = 209715200
          segment_index_bytes                 = 10485760
          segment_jitter_ms                   = 0
          segment_ms                          = 604800000
        }]
      }
    ]
  }
}
run "database_mysql_config" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-mysql-cluster"
        engine     = "mysql"
        version    = "8"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
        node_count = 1
      }
    ]
    database_mysql_config = [
      {
        id                = 0
        cluster_id        = 0
        connect_timeout   = 10
        default_time_zone = "UTC"
      }
    ]
  }
}
run "database_redis_config" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-redis-cluster"
        engine     = "redis"
        version    = "7"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
        node_count = 1
      }
    ]
    database_redis_config = [
      {
        id                     = 0
        cluster_id             = 0
        maxmemory_policy       = "allkeys-lru"
        notify_keyspace_events = "KEA"
        timeout                = 90
      }
    ]
  }
}
run "database_replica" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-redis-cluster"
        engine     = "pg"
        version    = "7"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
        node_count = 1
      }
    ]
    database_replica = [
      {
        id         = 0
        cluster_id = 0
        name       = "replica-example"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
      }
    ]
  }
}
run "database_user" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    database_cluster = [
      {
        id         = 0
        name       = "example-redis-cluster"
        engine     = "redis"
        version    = "7"
        size       = "db-s-1vcpu-1gb"
        vpc_id     = 0
        node_count = 1
      }
    ]
    database_user = [
      {
        id         = 0
        cluster_id = 0
        name       = "foobar"
      }
    ]
  }
}

run "domain" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    domain = [
      {
        id         = 0
        name       = "example.com"
        droplet_id = 0
      }
    ]
  }
}

run "droplet" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
  }
}

run "droplet_snapshot" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    droplet_snapshot = [
      {
        id         = 0
        droplet_id = 0
        name       = "web-snapshot-01"
      }
    ]
  }
}

run "firewall" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    firewall = [
      {
        id          = 0
        name        = "only-22-80-and-443"
        droplet_ids = [0]
        inbound_rule = [{
          protocol         = "tcp"
          port_range       = "22"
          source_addresses = ["192.168.1.0/24", "2002:1:2::/48"]
        }]
        inbound_rule = [{
          protocol         = "tcp"
          port_range       = "80"
          source_addresses = ["0.0.0.0/0", "::/0"]
        }]
        inbound_rule = [{
          protocol         = "tcp"
          port_range       = "443"
          source_addresses = ["0.0.0.0/0", "::/0"]
        }]
        inbound_rule = [{
          protocol         = "icmp"
          source_addresses = ["0.0.0.0/0", "::/0"]
        }]
        outbound_rule = ][{
          protocol              = "tcp"
          port_range            = "53"
          destination_addresses = ["0.0.0.0/0", "::/0"]
        }]
        outbound_rule = [{
          protocol              = "udp"
          port_range            = "53"
          destination_addresses = ["0.0.0.0/0", "::/0"]
        }]
        outbound_rule = [{
          protocol              = "icmp"
          destination_addresses = ["0.0.0.0/0", "::/0"]
        }]
      }]
    ]
  }
}

run "floating_ip" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    floating_ip = [
      {
        id         = 0
        droplet_id = 0
      }
    ]
  }
}

run "floating_ip_assignment" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    floating_ip = [
      {
        id         = 0
        droplet_id = 0
      }
    ]
    floating_ip_assignment = [
      {
        id         = 0
        ip_address = 0
        droplet_id = 0
      }
    ]
  }
}

run "kubernetes_cluster" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    kubernetes_cluster = [
      {
        id      = 0
        name    = "foo"
        vpc_id  = 0
        version = "1.22.8-do.1"
        node_pool = [{
          name       = "worker-pool"
          size       = "s-2vcpu-2gb"
          node_count = 3
          taint = [{
            key    = "workloadKind"
            value  = "database"
            effect = "NoSchedule"
          }]
        }]
      }
    ]
  }
}

run "kubernetes_node_pool" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    kubernetes_cluster = [
      {
        id      = 0
        name    = "foo"
        vpc_id  = 0
        version = "1.22.8-do.1"
        node_pool = [{
          name       = "worker-pool"
          size       = "s-2vcpu-2gb"
          node_count = 3
          taint = [{
            key    = "workloadKind"
            value  = "database"
            effect = "NoSchedule"
          }]
        }]
      }
    ]
    kubernetes_node_pool = [
      {
        id         = 0
        cluster_id = 0
        name       = "backend-pool"
        size       = "c-2"
        node_count = 2
        tags       = ["backend"]
      }
    ]
  }
}

run "loadbalancer" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    loadbalancer = [
      {
        id          = 0
        name        = "loadbalancer-1"
        vpc_id      = 0
        droplet_ids = [0]
        forwarding_rule = [{
          entry_port     = 80
          entry_protocol = "http"
          target_port     = 80
          target_protocol = "http"
        }]
        healthcheck = [{
          port     = 22
          protocol = "tcp"
        }]
      }
    ]
  }
}

run "monitor_alert" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    monitor_alert = [
      {
        id = 0
        alerts = [{
          email = ["sammy@digitalocean.com"]
          channel = "Production Alerts"
          url     = "https://hooks.slack.com/services/T1234567/AAAAAAAA/ZZZZZZ"
        }]
        window      = "5m"
        type        = "v1/insights/droplet/cpu"
        compare     = "GreaterThan"
        value       = 95
        enabled     = true
        entities    = [0]
        description = "Alert about CPU usage"
      }
    ]
  }
}

run "project" {
  command = apply

  variables {
    project = [
      {
        id          = 0
        name        = "playground"
        description = "A project to represent development resources."
        purpose     = "Web Application"
        environment = "Development"
      }
    ]
  }
}

run "project_resources" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    project = [
      {
        id          = 0
        name        = "playground"
        description = "A project to represent development resources."
        purpose     = "Web Application"
        environment = "Development"
      }
    ]
    project_resources = [
      {
        id = 0
        project_id = 0
        resources = [
          digitalocean_droplet.foobar.urn
        ]
      }
    ]
  }
}

run "record" {
  command = apply

  variables {
    domain = [
      {
        id         = 0
        name       = "example.com"
      }
    ]
    record = [
      {
        id     = 0
        domain = 0
        type   = "A"
        name   = "www"
        value  = "192.168.0.11"
      }
    ]
  }
}

run "reserved_ip" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    reserved_ip = [
      {
        id         = 0
        droplet_id = digitalocean_droplet.example.id
      }
    ]
  }
}

run "reserved_ip_assignment" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    reserved_ip = [
      {
        id         = 0
        droplet_id = digitalocean_droplet.example.id
      }
    ]
    reserved_ip_assignment = [
      {
        id            = 0
        ip_address_id = 0
        droplet_id    = 0
      }
    ]
  }
}

run "spaces_bucket" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    spaces_bucket = [
      {
        id     = 0
        name   = "foobar"
        vpc_id = 0
      }
    ]
  }
}

run "spaces_bucket_cors_configuration" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    spaces_bucket = [
      {
        id     = 0
        name   = "foobar"
        vpc_id = 0
      }
    ]
    spaces_bucket_cors_configuration = [
      {
        id     = 0
        bucket = digitalocean_spaces_bucket.foobar.id
        vpc_id = 0
        cors_rule = [{
          allowed_headers = ["*"]
          allowed_methods = ["PUT", "POST"]
          allowed_origins = ["https://s3-website-test.hashicorp.com"]
          expose_headers  = ["ETag"]
          max_age_seconds = 3000
        }]
      }
    ]
  }
}

run "spaces_bucket_object" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    spaces_bucket = [
      {
        id     = 0
        name   = "foobar"
        vpc_id = 0
      }
    ]
    spaces_bucket_object = [
      {
        id           = 0
        vpc_id       = 0
        bucket_id    = 0
        key          = "index.html"
        content      = "<html><body><p>This page is empty.</p></body></html>"
        content_type = "text/html"
      }
    ]
  }
}

run "spaces_bucket_policy" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    spaces_bucket = [
      {
        id     = 0
        name   = "foobar"
        vpc_id = 0
      }
    ]
    spaces_bucket_policy = [
      {
        id        = 0
        vpc_id    = 0
        bucket_id = 0
        policy = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
          ...
          ]
        })
      }
    ]
  }
}

run "ssh_key" {
  command = apply

  variables {
    ssh_key = [
      {
        id         = 0
        name       = "Terraform Example"
        public_key = file("/Users/terraform/.ssh/id_rsa.pub")
      }
    ]
  }
}

run "tag" {
  command = apply

  variables {
    tag = [
      {
        id   = 0
        name = "foobar"
      }
    ]
  }
}

run "uptime_alert" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    uptime_check = [
      {
        id      = 0
        name    = "example-europe-check"
        target  = "https://www.example.com"
        vpc_id  = [0]
      }
    ]
    uptime_alert = [
      {
        id = 0
        name       = "latency-alert"
        check_id   = 0
        type       = "latency"
        threshold  = 300
        comparison = "greater_than"
        period     = "2m"
        notifications = [{
          email   = ["sammy@digitalocean.com"]
          channel = "Production Alerts"
          url     = "https://hooks.slack.com/services/T1234567/AAAAAAAA/ZZZZZZ"
        }]
      }
    ]
  }
}

run "uptime_check" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    uptime_check = [
      {
        id      = 0
        name    = "example-europe-check"
        target  = "https://www.example.com"
        vpc_id  = [0]
      }
    ]
  }
}

run "volume" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    volume = [
      {
        id                      = 0
        vpc_id                  = 0
        name                    = "baz"
        size                    = 100
        initial_filesystem_type = "ext4"
        description             = "an example volume"
      }
    ]
  }
}

run "volume_attachment" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    droplet = [
      {
        id     = 0
        image  = "ubuntu-20-04-x64"
        name   = "web-1"
        vpc_id = 0
        size   = "s-1vcpu-1gb"
      }
    ]
    volume = [
      {
        id                      = 0
        vpc_id                  = 0
        name                    = "baz"
        size                    = 100
        initial_filesystem_type = "ext4"
        description             = "an example volume"
      }
    ]
    volume_attachment = [
      {
        id         = 0
        droplet_id = 0
        volume_id  = 0
      }
    ]
  }
}

run "volume_snapshot" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
    volume = [
      {
        id                      = 0
        vpc_id                  = 0
        name                    = "baz"
        size                    = 100
        initial_filesystem_type = "ext4"
        description             = "an example volume"
      }
    ]
    volume_snapshot = [
      {
        id        = 0
        name      = "foo"
        volume_id = 0
      }
    ]
  }
}

run "vpc" {
  command = apply

  variables {
    vpc = [
      {
        id       = 0
        name     = "example-project-network"
        region   = "nyc3"
        ip_range = "10.10.10.0/24"
      }
    ]
  }
}
