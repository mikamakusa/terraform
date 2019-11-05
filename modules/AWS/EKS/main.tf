resource "aws_iam_role" "eks_cluster_iam" {
  count                 = length(var.eks_iam_role)
  name                  = lookup(var.eks_iam_role[count.index], "name", null)
  name_prefix           = lookup(var.eks_iam_role[count.index], "name_prefix", null) ? aws_iam_role.eks_cluster_iam.name : ""
  assume_role_policy    = file("${path.cwd}/policy/eks_policy.json")
  permissions_boundary  = lookup(var.eks_iam_role[count.index], "permissions_boundary", null)
  path                  = lookup(var.eks_iam_role[count.index], "path", null)
  force_detach_policies = lookup(var.eks_iam_role[count.index], "force_detach_policies", true)
  tags                  = lookup(var.eks_iam_role[count.index], "tags", null)
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachement" {
  count      = length(var.eks_iam_policy) == "0" ? "0" : length(var.eks_iam_role)
  policy_arn = element(aws_iam_policy.iam_policy.*.arn, lookup(var.eks_iam_policy[count.index], "policy_id"))
  role       = element(aws_iam_role.eks_cluster_iam.name, lookup(var.eks_iam_policy[count.index], "iam_role_id"))
}

resource "aws_iam_instance_profile" "eks_iam_instance_profile" {
  count       = length(var.eks_iam_role) == "0" ? "0" : length(var.instance_profile)
  name        = lookup(var.instance_profile[count.index], "name", null)
  name_prefix = lookup(var.instance_profile[count.index], "name_prefix", null) ? aws_iam_instance_profile.eks_iam_instance_profile.name : ""
  role        = element(aws_iam_role.eks_cluster_iam.*.name, lookup(var.instance_profile[count.index], "role_id"))
}

resource "aws_iam_policy" "iam_policy" {
  count       = length(var.iam_policy)
  name        = lookup(var.iam_policy[count.index], "name")
  name_prefix = lookup(var.iam_policy[count.index], "name_prefix", null) ? aws_iam_policy.iam_policy.name : ""
  policy      = "${file(path.cwd)}/policy/${lookup(var.iam_policy[count.index], "name")}.json"
  path        = lookup(var.iam_policy[count.index], "path", null)
}

resource "aws_security_group" "eks_security_group" {
  count       = length(var.eks_security_group)
  name        = lookup(var.eks_security_group[count.index], "name", null)
  name_prefix = lookup(var.eks_security_group[count.index], "name_prefix", null) ? aws_security_group.eks_security_group.name : ""
  description = lookup(var.eks_security_group[count.index], "description", null)
  vpc_id      = data.terraform_remote_state.vpc.id
  tags        = lookup(var.eks_security_group[count.index], "tags", null)
}

resource "aws_security_group_rule" "eks_security_rule" {
  count             = length(var.eks_security_rule) == "0" ? "0" : length(var.eks_security_group)
  from_port         = lookup(var.eks_security_rule[count.index], "from_port")
  protocol          = lookup(var.eks_security_rule[count.index], "protocol")
  security_group_id = element(aws_security_group.eks_security_group.*.id, lookup(var.eks_security_rule[count.index], "security_group_id"))
  to_port           = lookup(var.eks_security_rule[count.index], "to_port")
  type              = lookup(var.eks_security_rule[count.index], "type")
}

resource "aws_subnet" "eks_subnet" {
  count                   = length(var.eks_subnet)
  cidr_block              = lookup(var.eks_subnet[count.index], "cidr_block")
  vpc_id                  = data.terraform_remote_state.vpc.id
  availability_zone       = lookup(var.eks_subnet[count.index], "availability_zone")
  map_public_ip_on_launch = lookup(var.eks_subnet[count.index], "map_public_ip_on_launch")

  dynamic "lifecycle" {
    for_each = lookup(var.eks_subnet[count.index], "lifecycle")
    content {
      prevent_destroy       = lookup(lifecycle.value[count.index], "prevent_destroy", false)
      create_before_destroy = lookup(lifecycle.value[count.index], "create_before_destroy", false)
    }
  }
}

resource "aws_cloudwatch_log_group" "eks_cloudwatch" {
  count             = length(var.eks_cloudwatch)
  name              = lookup(var.eks_cloudwatch[count.index], "name")
  retention_in_days = lookup(var.eks_cloudwatch[count.index], "retention_in_days", null)
  kms_key_id        = lookup(var.eks_cloudwatch[count.index], "kms_key_id", null)
  tags              = lookup(var.eks_cloudwatch[count.index], "tags", null)
}

resource "aws_iam_service_linked_role" "eks" {
  aws_service_name = "autoscaling.amazonaws.com"
}

resource "aws_eks_cluster" "eks_cluster" {
  count                     = length(var.eks_cluster) == "0" ? "0" : length(var.eks_cloudwatch)
  name                      = lookup(var.eks_cluster[count.index], "name")
  role_arn                  = element(aws_iam_role.eks_cluster_iam.arn, lookup(var.eks_cluster[count.index], "iam_role_id"))
  enabled_cluster_log_types = [lookup(var.eks_cluster[count.index], "enabled_cluster_log_types", null)]
  version                   = lookup(var.eks_cluster[count.index], "version", null)

  dynamic "vpc_config" {
    for_each = lookup(var.eks_cluster[count.index], "vpc_config")
    content {
      endpoint_private_access = lookup(vpc_config.value, "endpoint_private_access", null)
      endpoint_public_access  = lookup(vpc_config.value, "endpoint_public_access", null)
      security_group_ids      = [element(aws_security_group.eks_security_group.*.id, lookup(var.eks_cluster[count.index], "security_group_id"))]
      subnet_ids              = [element(aws_subnet.eks_subnet.*.id, lookup(var.eks_cluster[count.index], "subnet_id"))]
    }
  }

  tags = lookup(var.eks_cluster[count.index], "tags", null)
}

resource "aws_launch_configuration" "eks_worker_configuration" {
  count                       = length(var.wk_config)
  name                        = lookup(var.wk_config[count.index], "name", null)
  name_prefix                 = lookup(var.wk_config[count.index], "name_prefix", null) ? aws_launch_configuration.eks_worker_configuration.name : ""
  image_id                    = lookup(var.wk_config[count.index], "image_id")
  instance_type               = lookup(var.wk_config[count.index], "instance_type")
  security_groups             = [element(aws_security_group.eks_security_group.*.id, lookup(var.wk_config[count.index], "security_group_id"))]
  associate_public_ip_address = lookup(var.wk_config[count.index], "associate_public_ip_address", false)
  iam_instance_profile        = lookup(var.wk_config[count.index], "iam_instance_profile", null)
  key_name                    = lookup(var.wk_config[count.index], "key_name", null)
  enable_monitoring           = lookup(var.wk_config[count.index], "enable_monitoring", true)
  spot_price                  = lookup(var.wk_config[count.index], "spot_price")
  placement_tenancy           = lookup(var.wk_config[count.index], "placement_tenancy")

  dynamic "root_block_device" {
    for_each = lookup(var.wk_config[count.index], "root_block_device")
    content {
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(root_block_device.value, "encrypted", true)
    }
  }

  dynamic "lifecycle" {
    for_each = lookup(var.wk_config[count.index], "lifecycle")
    content {
      prevent_destroy       = lookup(lifecycle.value, "prevent_destroy", false)
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", false)
    }
  }
}

resource "aws_autoscaling_group" "aws_eks_worker_autoscalling" {
  count                   = length(var.workers)
  name                    = lookup(var.workers[count.index], "name")
  name_prefix             = lookup(var.workers[count.index], "name_prefix", null) ? aws_autoscaling_group.aws_eks_worker_autoscalling.name : ""
  max_size                = lookup(var.workers[count.index], "max_size")
  min_size                = lookup(var.workers[count.index], "min_size")
  desired_capacity        = lookup(var.workers[count.index], "desired_capacity", null)
  force_delete            = lookup(var.workers[count.index], "force_delete", false)
  target_group_arns       = [lookup(var.workers[count.index], "target_group_arns", null)]
  service_linked_role_arn = aws_iam_service_linked_role.eks.arn
  launch_configuration    = element(aws_launch_configuration.eks_worker_configuration.*.name, lookup(var.workers[count.index], "configuration_name"))
  protect_from_scale_in   = lookup(var.workers[count.index], "protect_from-scale_in", null)
  suspended_processes     = lookup(var.workers[count.index], "suspended_processes", null)
  enabled_metrics         = lookup(var.workers[count.index], "enabled_metrics", null)
  placement_group         = lookup(var.workers[count.index], "placement_group", null)
  termination_policies    = lookup(var.workers[count.index], "termination_policies", null)

  dynamic "initial_lifecycle_hook" {
    for_each = lookup(var.workers[count.index], "initial_lifecycle_hook")
    content {
      lifecycle_transition = lookup(initial_lifecycle_hook.value, "lifecycle_transition")
      name                 = lookup(initial_lifecycle_hook.value, "name")
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = lookup(var.workers[count.index], "mixed_instances_policy")
    content {
      launch_template {
        launch_template_specification {
          launch_template_id   = lookup(mixed_instances_policy.value, "launch_template_id", null)
          launch_template_name = lookup(mixed_instances_policy.value, "launch_template_name", null)
          version              = lookup(mixed_instances_policy.value, "version", null)
        }
      }
      instances_distribution {
        on_demand_allocation_strategy            = lookup(mixed_instances_policy.value, "on_demand_allocation_strategy", null)
        on_demand_base_capacity                  = lookup(mixed_instances_policy.value, "on_demand_base_capacity", null)
        on_demand_percentage_above_base_capacity = lookup(mixed_instances_policy.value, "on_demand_percentage_above_base_capacity", null)
        spot_allocation_strategy                 = lookup(mixed_instances_policy.value, "spot_allocation_strategy", null)
        spot_instance_pools                      = lookup(mixed_instances_policy.value, "spot_instance_pools", null)
        spot_max_price                           = lookup(mixed_instances_policy.value, "spot_max_price", null)
      }
    }
  }

  dynamic "lifecycle" {
    for_each = lookup(var.workers[count.index], "lifecycle")
    content {
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", null)
      prevent_destroy       = lookup(lifecycle.value, "prevent_destrot", null)
    }
  }
}
