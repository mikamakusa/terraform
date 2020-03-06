output "vpc_id" {
  description = "VPC ID"
  value = module.vpc.vpc_id
}

output "subnet_id" {
  description = "Subnet ID"
  value = module.subnets.subnet_id
}

output "security_group_id" {
  description = "Security group Id"
  value = module.security_group.security_group_id
}