# How to use this module ?

````yaml
elastic_policy_name = "xxxxxxxx-elasticsearch"

SecGroupName = "elastic"

SecGroupRules = [
  {
    from_port   = "0"
    protocol    = "tcp"
    to_port     = "65535"
    type        = "ingress"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = "0"
    protocol    = "tcp"
    to_port     = "65535"
    type        = "egress"
    cidr_blocks = "0.0.0.0/0"
  }
]

elasticsearch = [
  {
    domain_name           = "xxxxxxxxx-es-test"
    elasticsearch_version = "7.1"
    cluster_config = [{
      instance_type  = "r4.large.elasticsearch"
      instance_count = "1"
      //      dedicated_master_count   = "2"
      //      dedicated_master_enabled = "1"
      dedicated_master_type = "r4.large.elasticsearch"
    }]
    ebs_options = [{
      ebs_enabled = "true"
      volume_type = "standard"
      volume_size = "100"
    }]
    encrypt_at_rest = [{
      // kms_key_id = ""
    }]
    log_publishing_options = [{
      log_type = "INDEX_SLOW_LOGS"
    }]
    snapshot_options = [{
      automated_snapshot_start_hour = "12"
    }]
  }
]
’’’
