output "vpc_id" {
  description = "VPC ID"
  value = module.vpc.*.vpc_id
}

output "subnet_id" {
  description = "Subnet ID"
  value = module.subnets.*.subnet_id
}
