resource "aws_security_group" "elastic_security_group" {
  vpc_id = data.terraform_remote_state.vpc.defaults
  name   = var.SecGroupName
}

resource "aws_security_group_rule" "aws_security_rule" {
  count             = length(var.SecGroupRules)
  from_port         = lookup(var.SecGroupRules[count.index], "from_port")
  protocol          = lookup(var.SecGroupRules[count.index], "protocol")
  security_group_id = aws_security_group.aws_security_group.id
  to_port           = lookup(var.SecGroupRules[count.index], "to_port")
  type              = lookup(var.SecGroupRules[count.index], "type")
  cidr_blocks       = [lookup(var.SecGroupRules[count.index], "cidr_blocks")]
}

resource "aws_iam_service_linked_role" "aws_linked_role_es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_cloudwatch_log_group" "aws_cw_es_group" {
  name = join("-",[var.elastic_policy_name,"group"])
}

resource "aws_cloudwatch_log_resource_policy" "aws_cw_es_policy" {
  policy_name = join("-",[var.elastic_policy_name,"policy"])
  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
CONFIG
}

resource "aws_elasticsearch_domain" "engie_elastic" {
  count                 = length(var.elasticsearch)
  domain_name           = lookup(var.elasticsearch[count.index], "domain_name")
  elasticsearch_version = lookup(var.elasticsearch[count.index], "elasticsearch_version")

  vpc_options {
    security_group_ids = [join("", aws_security_group.aws_security_group.*.id)]
    subnet_ids         = [element(data.terraform_remote_state.vpc.outputs.private_subnets, 0)]
  }

  dynamic "cluster_config" {
    for_each = lookup(var.elasticsearch[count.index], "cluster_config")
    content {
      dedicated_master_count   = lookup(cluster_config.value, "dedicated_master_count", null)
      dedicated_master_enabled = lookup(cluster_config.value, "dedicated_master_enabled", null)
      dedicated_master_type    = lookup(cluster_config.value, "dedicated_master_type", null)
      instance_count           = lookup(cluster_config.value, "instance_count", null)
      instance_type            = lookup(cluster_config.value, "instance_type", null)
      zone_awareness_enabled   = lookup(cluster_config.value, "zone_awareness_enabled", null)

      dynamic "zone_awareness_config" {
        for_each = lookup(cluster_config.value, "zone_awareness_config", [])
        content {
          availability_zone_count = lookup(zone_awareness_config.value, "availability_zone_count", null)
        }
      }
    }
  }

  dynamic "ebs_options" {
    for_each = lookup(var.elasticsearch[count.index], "ebs_options")
    content {
      ebs_enabled = lookup(ebs_options.value, "ebs_enabled", true)
      iops        = lookup(ebs_options.value, "iops", null)
      volume_size = lookup(ebs_options.value, "volume_size", null)
      volume_type = lookup(ebs_options.value, "volume_type", null)
    }
  }

  dynamic "encrypt_at_rest" {
    for_each = lookup(var.elasticsearch[count.index], "encrypt_at_rest")
    content {
      enabled    = lookup(encrypt_at_rest.value, "enabled", false)
      kms_key_id = lookup(encrypt_at_rest.value, "kms_key_id", null)
    }
  }

  dynamic "log_publishing_options" {
    for_each = lookup(var.elasticsearch[count.index], "log_publishing_options")
    content {
      log_type                 = lookup(log_publishing_options.value, "log_type", null)
      cloudwatch_log_group_arn = lookup(log_publishing_options.value, "cloudwatch_log_group_arn", aws_cloudwatch_log_group.aws_cw_es_group.arn)
      enabled                  = lookup(log_publishing_options.value, "enabled", true)
    }
  }

  dynamic "snapshot_options" {
    for_each = lookup(var.elasticsearch[count.index],"snapshot_options")
    content {
      automated_snapshot_start_hour = lookup(snapshot_options.value,"automated_snapshot_start_hour", null)
    }
  }
}
