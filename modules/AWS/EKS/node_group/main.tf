resource "aws_eks_node_group" "node_group" {
  count           = length(var.node_group)
  cluster_name    = element(var.cluster_name, lookup(var.node_group[count.index], "cluster_id"))
  node_group_name = lookup(var.node_group[count.index], "node_group_name")
  node_role_arn   = element(var.role_arn, lookup(var.node_group[count.index], "role_id"))
  subnet_ids      = element(var.subnet_id, lookup(var.node_group[count.index], "subnet_id"))
  ami_type        = lookup(var.node_group[count.index], "ami_type")
  disk_size       = lookup(var.node_group[count.index], "disk_size")
  instance_types  = lookup(var.node_group[count.index], "instance_types")
  labels          = lookup(var.node_group[count.index], "labels")
  release_version = lookup(var.node_group[count.index], "release_version")
  tags            = var.tags
  version         = lookup(var.node_group[count.index], "version")

  dynamic "scaling_config" {
    for_each = lookup(var.node_group[count.index], "scaling_config")
    content {
      desired_size = lookup(scaling_config.value, "desired_size")
      max_size     = lookup(scaling_config.value, "max_size")
      min_size     = lookup(scaling_config.value, "min_size")
    }
  }

  dynamic "remote_access" {
    for_each = lookup(var.node_group[count.index], "remote_access")
    content {
      ec2_ssh_key               = lookup(remote_access.value, "ec2_ssh_key")
      source_security_group_ids = element(var.security_group_id, lookup(remote_access.value, "source_security_group_id"))
    }
  }
}