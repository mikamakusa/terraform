# How to use this module

### aws_elasticache_security_group resource
```yaml
SecGroup = [
  {
    name = ""
  }
]
```

### aws_elasticache_subnet_group resource
```yaml
SubnetGroup = [
  {
    name = ""
  }
]
```

### aws_elasticache_cluster resource
```yaml
elasticache = [
  {
    cluster_id = ""
    engine = ""
    engine_version = "" //optional
    maintenance_window = "" //optional
    port = "" //optional
    snapshot_name = "" //optional
    snapshot_retention_limit = "" //optional
    az_mode = "" //optional
    preferred_availability_zones = "" //only if engine is "memcached"
  }
]
```

### aws_elasticache_parameter_group resource
```yaml
ParamGroup = [
  {
    family = ""
    name = ""
  
    parameter = [
      {
        name = "" //optional
        value = "" //optional
      }
    ]
  }
]
```

### aws_elasticache_replication_group resource
```yaml
RepGroup = [
  {
    replication_group_description = ""
    replication_group_id = ""
    node_type = "" //optional
    port = "" //optional
    parameter_group_name = ""
    automatic_failover_enabled = "" //default to false
    engine = "" //optional
    engine_version = "" //optional
    at_rest_encryption_enabled = "" //optional
    transit_encryption_enabled = "" //optional
    auth_token = "" //only if transit_encryption_enabled is "true"
    maintenance_window = "" //optional
    snapshot_name = "" //optional
    snapshot_retention_limit = "" //only if engine is "redis"
    snapshot_window = "" //optional
    apply_immediately = "" //optional
    
    //only if "automatic_failover_enabled" is "true"
    cluster_mode = [
      {
        replicas_per_node_group = ""
        num_node_groups = ""
      }
    ]
  }
]
```