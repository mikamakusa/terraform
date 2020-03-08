# IAM
module "iam_role" {
  source   = "../../../modules/AWS/IAM/iam_role"
  iam_role = var.iam_role
}

module "iam_policy" {
  source     = "../../../modules/AWS/IAM/iam_policy"
  iam_policy = var.iam_policy
}

module "iam_role_policy_attachment" {
  source                     = "../../../modules/AWS/IAM/iam_role_policy_attachment"
  iam_role                   = module.iam_role.iam_role_name
  iam_role_policy_attachment = var.iam_role_policy_attachment
}

module "instance_profile" {
  source           = "../../../modules/AWS/IAM/instance_profile"
  instance_profile = var.instance_profile
  role_name        = module.iam_role.iam_role_name
}

module "service_linked_role" {
  source              = "../../../modules/AWS/IAM/service_linked_role"
  service_linked_role = var.service_linked_role
}

module "openid_connect_provider" {
  source                  = "../../../modules/AWS/IAM/openid_connect_provider"
  openid_connect_provider = var.openid_connect_provider
}

# VPC
module "vpc" {
  source = "../../../modules/AWS/VPC/vpc"
  vpc    = var.vpc
  tags   = local.vpc_tags
}

module "security_group" {
  source         = "../../../modules/AWS/VPC/security_groups"
  security_group = var.security_group
  vpc_id         = module.vpc.vpc_id
  tags           = local.sg_tags
}

module "security_group_rule" {
  source              = "../../../modules/AWS/VPC/security_group_rule"
  security_group_id   = module.security_group.security_group_id
  security_group_rule = var.security_group_rule
}

module "subnet" {
  source = "../../../modules/AWS/VPC/subnet"
  subnet = var.subnet
  vpc_id = module.vpc.vpc_id
  tags   = local.subnet_tags
}

# Cloudwatch
module "cloudwatch_log_group" {
  source     = "../../../modules/AWS/CloudWatch/log_group"
  kms_key_id = ""
  log_group  = var.log_group
  tags       =
}

# EKS - master node
module "eks_cluster" {
  source            = "../../../modules/AWS/EKS/cluster"
  eks_cluster       = var.eks_cluster
  role_arn          = module.iam_role.iam_role_arn
  security_group_id = module.security_group.security_group_id
  subnet_id         = module.subnet.subnet_id
  tags              = local.eks_tags
}

# workers
module "node_group" {
  source            = "../../../modules/AWS/EKS/node_group"
  cluster_name      = module.eks_cluster.eks_cluster_name
  node_group        = var.node_group
  role_arn          = module.iam_role.iam_role_arn
  security_group_id = module.security_group.security_group_id
  subnet_id         = module.subnet.subnet_id
  tags              = local.worker_tags
}