resource "aws_eks_access_entry" "this" {
  count             = length(var.access_entry) == "0" ? "0" : length(var.cluster)
  cluster_name      = try(element(aws_eks_cluster.this.*.name, lookup(var.access_entry[count.index], "cluster_id")))
  principal_arn     = lookup(var.access_entry[count.index], "principal_arn")
  kubernetes_groups = lookup(var.access_entry[count.index], "kubernetes_groups")
  type              = lookup(var.access_entry[count.index], "type")
  tags              = merge(var.tags, lookup(var.access_entry[count.index], "tags"))
  user_name         = lookup(var.access_entry[count.index], "user_name")
}

resource "aws_eks_access_policy_association" "this" {
  count         = length(var.access_policy_association) == "0" ? "0" : length(var.cluster)
  cluster_name  = try(element(aws_eks_cluster.this.*.name, lookup(var.access_policy_association[count.index], "cluster_id")))
  policy_arn    = lookup(var.access_policy_association[count.index], "policy_arn")
  principal_arn = lookup(var.access_policy_association[count.index], "principal_arn")

  dynamic "access_scope" {
    for_each = lookup(var.access_policy_association[count.index], "access_scope")
    content {
      type       = lookup(access_scope.value, "type")
      namespaces = lookup(access_scope.value, "namespaces")
    }
  }
}

resource "aws_eks_addon" "this" {
  count                       = length(var.addon)
  addon_name                  = lookup(var.addon[count.index], "addon_name")
  cluster_name                = try(element(aws_eks_cluster.this.*.name, lookup(var.addon[count.index], "cluster_id")))
  addon_version               = lookup(var.addon[count.index], "addon_version")
  configuration_values        = lookup(var.addon[count.index], "configuration_values")
  resolve_conflicts_on_create = lookup(var.addon[count.index], "resolve_conflicts_on_create")
  resolve_conflicts_on_update = lookup(var.addon[count.index], "resolve_conflicts_on_update")
  tags                        = merge(var.tags, lookup(var.addon[count.index], "tags"))
  preserve                    = lookup(var.addon[count.index], "preserve")
  service_account_role_arn    = lookup(var.addon[count.index], "service_account_role_arn")
}

resource "aws_eks_cluster" "this" {
  count                     = length(var.cluster)
  name                      = lookup(var.cluster[count.index], "name")
  role_arn                  = lookup(var.cluster[count.index], "role_arn")
  enabled_cluster_log_types = lookup(var.cluster[count.index], "enabled_cluster_log_types")
  tags                      = {}
  version                   = lookup(var.cluster[count.index], "version")

  dynamic "access_config" {
    for_each = lookup(var.cluster[count.index], "access_config") == null ? [] : ["access_config"]
    content {
      authentication_mode                         = lookup(access_config.value, "authentication_mode")
      bootstrap_cluster_creator_admin_permissions = lookup(access_config.value, "bootstrap_cluster_creator_admin_permissions")
    }
  }

  dynamic "encryption_config" {
    for_each = lookup(var.cluster[count.index], "encryption_config") == null ? [] : ["encryption_config"]
    content {
      resources = lookup(encryption_config.value, "resources")

      dynamic "provider" {
        for_each = lookup(encryption_config.value, "provider") == null ? [] : ["provider"]
        content {
          key_arn = lookup(provider.value, "key_arn")
        }
      }
    }
  }

  dynamic "kubernetes_network_config" {
    for_each = lookup(var.cluster[count.index], "kubernetes_network_config") == null ? [] : ["kubernetes_network_config"]
    content {
      service_ipv4_cidr = lookup(kubernetes_network_config.value, "service_ipv4_cidr")
      ip_family         = lookup(kubernetes_network_config.value, "ip_family")
    }
  }

  dynamic "vpc_config" {
    for_each = lookup(var.cluster[count.index], "vpc_config")
    content {
      subnet_ids              = lookup(vpc_config.value, "subnet_ids")
      endpoint_private_access = lookup(vpc_config.value, "endpoint_private_access")
      endpoint_public_access  = lookup(vpc_config.value, "endpoint_public_access")
      public_access_cidrs     = lookup(vpc_config.value, "public_access_cidrs")
      security_group_ids      = lookup(vpc_config.value, "security_group_ids")
    }
  }

  dynamic "outpost_config" {
    for_each = lookup(var.cluster[count.index], "outpost_config") == null ? [] : ["outpost_config"]
    content {
      control_plane_instance_type = lookup(outpost_config.value, "control_plane_instance_type")
      outpost_arns                = lookup(outpost_config.value, "outpost_arns")

      dynamic "control_plane_placement" {
        for_each = lookup(outpost_config.value, "control_plane_placement") == null ? [] : ["control_plane_placement"]
        content {
          group_name = lookup(control_plane_placement.value, "group_name")
        }
      }
    }
  }
}

resource "aws_eks_fargate_profile" "this" {
  count                  = length(var.fargate_profile) == "0" ? "0" : length(var.cluster)
  cluster_name           = try(element(aws_eks_cluster.this.*.name, lookup(var.fargate_profile[count.index], "cluster_id")))
  fargate_profile_name   = lookup(var.fargate_profile[count.index], "fargate_profile_name")
  pod_execution_role_arn = lookup(var.fargate_profile[count.index], "pod_execution_role_arn")
  subnet_ids             = lookup(var.fargate_profile[count.index], "subnet_ids")
  tags                   = merge(var.tags, lookup(var.fargate_profile[count.index], "tags"))

  dynamic "selector" {
    for_each = lookup(var.fargate_profile[count.index], "selector")
    content {
      namespace = lookup(selector.value, "namespace")
    }
  }
}

resource "aws_eks_identity_provider_config" "this" {
  count        = length(var.identity_provider_config) == "0" ? "0" : length(var.cluster)
  cluster_name = try(element(aws_eks_cluster.this.*.name, lookup(var.identity_provider_config[count.index], "cluster_id")))
  tags         = merge(var.tags, lookup(var.identity_provider_config[count.index], "tags"))

  dynamic "oidc" {
    for_each = lookup(var.identity_provider_config[count.index], "oidc")
    content {
      client_id                     = lookup(oidc.value, "client_id")
      identity_provider_config_name = lookup(oidc.value, "identity_provider_config_name")
      issuer_url                    = lookup(oidc.value, "issuer_url")
      groups_claim                  = lookup(oidc.value, "groups_claim")
      groups_prefix                 = lookup(oidc.value, "groups_prefix")
      required_claims               = lookup(oidc.value, "required_claims")
      username_claim                = lookup(oidc.value, "username_claim")
      username_prefix               = lookup(oidc.value, "username_prefix")
    }
  }
}

resource "aws_eks_node_group" "this" {
  count                = length(var.node_group) == "0" ? "0" : length(var.cluster)
  cluster_name         = try(element(aws_eks_cluster.this.*.name, lookup(var.node_group[count.index], "cluster_id")))
  node_group_name      = lookup(var.node_group[count.index], "node_group_name")
  node_role_arn        = lookup(var.node_group[count.index], "node_role_arn")
  subnet_ids           = lookup(var.node_group[count.index], "subnet_ids")
  ami_type             = lookup(var.node_group[count.index], "ami_type")
  capacity_type        = lookup(var.node_group[count.index], "capacity_type")
  disk_size            = lookup(var.node_group[count.index], "disk_size")
  force_update_version = lookup(var.node_group[count.index], "force_update_version")
  instance_types       = lookup(var.node_group[count.index], "instance_types")
  labels               = lookup(var.node_group[count.index], "labels")
  release_version      = lookup(var.node_group[count.index], "release_version")
  tags                 = merge(var.tags, lookup(var.node_group[count.index], "tags"))
  version              = lookup(var.node_group[count.index], "version")

  dynamic "launch_template" {
    for_each = lookup(var.node_group[count.index], "launch_template") == null ? [] : ["launch_template"]
    content {
      version = lookup(launch_template.value, "version")
      id      = lookup(launch_template.value, "id")
      name    = lookup(launch_template.value, "name")
    }
  }

  dynamic "remote_access" {
    for_each = lookup(var.node_group[count.index], "remote_access") == null ? [] : ["remote_access"]
    content {
      ec2_ssh_key               = lookup(remote_access.value, "ec2_ssh_key")
      source_security_group_ids = lookup(remote_access.value, "source_security_group_ids")
    }
  }

  dynamic "scaling_config" {
    for_each = lookup(var.node_group[count.index], "scaling_config") == null ? [] : ["scaling_config"]
    content {
      desired_size = lookup(scaling_config.value, "desired_size")
      max_size     = lookup(scaling_config.value, "max_size")
      min_size     = lookup(scaling_config.value, "min_size")
    }
  }

  dynamic "taint" {
    for_each = lookup(var.node_group[count.index], "taint") == null ? [] : ["taint"]
    content {
      key    = lookup(taint.value, "key")
      effect = lookup(taint.value, "effect")
      value  = lookup(taint.value, "value")
    }
  }

  dynamic "update_config" {
    for_each = lookup(var.node_group[count.index], "update_config") == null ? [] : ["update_config"]
    content {
      max_unavailable            = lookup(update_config.value, "max_unavailable")
      max_unavailable_percentage = lookup(update_config.value, "max_unavailable_percentage")
    }
  }
}

resource "aws_eks_pod_identity_association" "this" {
  count           = length(var.pod_identity_association) == "0" ? "0" : length(var.cluster)
  cluster_name    = try(element(aws_eks_cluster.this.*.name, lookup(var.pod_identity_association[count.index], "cluster_id")))
  namespace       = lookup(var.pod_identity_association[count.index], "namespace")
  role_arn        = lookup(var.pod_identity_association[count.index], "role_arn")
  service_account = lookup(var.pod_identity_association[count.index], "service_account")
  tags            = merge(var.tags, lookup(var.pod_identity_association[count.index], "tags"))
}