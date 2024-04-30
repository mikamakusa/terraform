output "cluster" {
  value = try(aws_eks_cluster.this)
}

output "node_group" {
  value = try(aws_eks_node_group.this)
}

output "addon" {
  value = try(aws_eks_addon.this)
}

output "fargate_profile" {
  value = try(aws_eks_fargate_profile.this)
}

output "identity_provider_config" {
  value = try(aws_eks_identity_provider_config.this)
}