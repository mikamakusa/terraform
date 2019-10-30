# How to use this module

### google_bigtable_instance resource
```yaml
bt_instance = [
  {
    name = ""
    project = "" //optional
    instance_type = "" //optional
    display_name = "" //optional

    cluster = [
      {
        cluster_id = ""
        zone = ""
        num_nodes = "" //optional
        storage_type = "" //optional
      }
    ]
  }
]
```

### google_bigtable_table
```yaml
bt_table = [
  {
    instance_name = ""
    name = ""
    split_keys = "" //optional
    project = "" //optional

    column_family = [
      {
        family = "" //optional
      }
    ]
  }
]
```

## Optional resources
### google_bigtable_app_profile resource
```yaml
app_profile = [
  {
    app_profile_id = ""
    multi_cluster_routing_use_any = "" //optional
    instance = "" //optional
    ignore_warnings = "" //optional - true or false
    project = "" //optional

    single_cluster_routing = [
      {
        cluster_id = "" //optional
        allow_transactional_writes = "" /optional
      }
    ]
  }
]
```

NB : `multi_cluster_routing_use_any` and `single_cluster_routing` are mutually exclusive.  
if the first one is set, please define `app_profile` like the following :  
```yaml
app_profile = [
  {
    app_profile_id = ""
    multi_cluster_routing_use_any = "" //optional
    instance = "" //optional
    ignore_warnings = "" //optional - true or false
    project = "" //optional

    single_cluster_routing = []
  }
]
```

### google_bigtable_gc_policy resource
```yaml
bt_policy = [
  {
    instance_name = ""
    table_name = ""
    column_family = ""
    project = "" //optional
    mode = "" //optional
    
    max_age = [
      {
        days = "" //optional
      }
    ]
  
    max_version = [
      {
        number = "" //optional
      }
    ]
  }
]
```