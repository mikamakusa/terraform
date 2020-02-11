resource "aws_vpc" "vpc" {
  count                            = length(var.vpc)
  cidr_block                       = lookup(var.vpc[count.index], "cidr_block")
  instance_tenancy                 = lookup(var.vpc[count.index], "instance_tenancy")
  enable_classiclink               = lookup(var.vpc[count.index], "enable_classiclink")
  enable_classiclink_dns_support   = lookup(var.vpc[count.index], "enable_classiclink_dns_support")
  enable_dns_hostnames             = lookup(var.vpc[count.index], "enable_dns_hostnames")
  enable_dns_support               = lookup(var.vpc[count.index], "enable_dns_support")
  assign_generated_ipv6_cidr_block = lookup(var.vpc[count.index], "assign_generated_ipv6_cidr_block")
}