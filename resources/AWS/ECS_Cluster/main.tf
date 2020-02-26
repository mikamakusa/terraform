#VPC
module "vpc" {
  source = "../../../modules/AWS/VPC/vpc"
  vpc    = var.vpc
  tags   = local.vpc_tags
}

module "subnet" {
  source = "../../../modules/AWS/VPC/subnet"
  subnet = var.subnet
  vpc_id = module.vpc.vpc_id
  tags   = local.subnet_tags
}

module "internet_gateway" {
  source           = "../../../modules/AWS/VPC/internet_gateway"
  internet_gateway = var.internet_gateway
  vpc_id           = module.vpc.vpc_id
  tags             = local.ig_tags
}

module "nat_gateway" {
  source      = "../../../modules/AWS/VPC/nat_gateway"
  eip_id      = module.eip.eip_id
  nat_gateway = var.nat_gateway
  subnet_id   = module.subnet.subnet_id
}

module "route_table" {
  source         = "../../../modules/AWS/VPC/route_table"
  route_table    = var.route_table
  vpc_id         = module.vpc.vpc_id
  gateway_id     = module.internet_gateway.intenet_gateway_id
  nat_gateway_id = module.nat_gateway.nat_gateway_id
  tags           = local.rt_tags
}

module "route_table_association" {
  source                  = "../../../modules/AWS/VPC/route_table_association"
  route_table_association = var.route_table_association
  route_table_id          = module.route_table.route_table_id
  subnet_id               = module.subnet.subnet_id
}

module "security_group" {
  source         = "../../../modules/AWS/VPC/security_groups"
  security_group = var.security_group
  vpc_id         = module.vpc.vpc_id
  tags           = local.sg_tags
}

module "security_group_rules" {
  source              = "../../../modules/AWS/VPC/security_group_rule"
  security_group_id   = module.security_group.security_group_id
  security_group_rule = var.security_group_rules
}

module "eip" {
  source               = "../../../modules/AWS/EC2/eip"
  eip                  = var.eip
  instance_id          = ""
  network_interface_id = ""
  vpc_id               = module.vpc.vpc_id
}

#IAM
module "service_linked_role" {
  source              = "../../../modules/AWS/IAM/service_linked_role"
  service_linked_role = var.service_linked_role
}

module "iam_role" {
  source   = "../../../modules/AWS/IAM/iam_role"
  iam_role = var.iam_role
}

module "role_policy" {
  source          = "../../../modules/AWS/IAM/iam_role_policy"
  iam_role_policy = ""
  role            = module.iam_role.iam_role_id
}

module "iam_instance_profile" {
  source           = "../../../modules/AWS/IAM/instance_profile"
  instance_profile = var.iam_instance_profile
  role_name        = module.iam_role.iam_role_id
}

# Load Balancer
module "launch_configuration" {
  source               = "../../../modules/AWS/EC2/launch_configuration"
  launch_configuration = var.launch_configuration
  security_group_ids   = module.security_group.security_group_id
}

module "autoscaling_group" {
  source                  = "../../../modules/AWS/Autoscaling/group"
  autoscalling_group      = var.autoscaling_group
  launch_configuration    = module.launch_configuration.launch_configuration_name
  service_linked_role_arn = module.service_linked_role.service_linked_role_arn
}

module "load_balancer" {
  source            = "../../../modules/AWS/ALB/lb"
  alb               = var.load_balancer
  security_group_id = module.security_group.*.security_group_id
  subnet_id         = module.subnet.*.subnet_id
  tags              = local.lb_tags
}

module "load_balancer_target_group" {
  source       = "../../../modules/AWS/ALB/target_group"
  tags         = local.lb_target_group_tags
  target_group = var.load_balancer_target_group
  vpc_id       = module.vpc.vpc_id
}

module "load_balancer_listener" {
  source            = "../../../modules/AWS/ALB/listener"
  listener          = var.load_balancer_listener
  load_balancer_arn = module.load_balancer.lb_arn
  target_group_arn  = module.load_balancer_target_group.target_group_arn
}

# ECS
module "capacity_provider" {
  source                = "../../../modules/AWS/ECS/capacity_provider"
  autoscaling_group_arn = module.autoscaling_group.autoscaling_group_arn
  capacity_provider     = var.capacity_provider
  tags                  = local.cp_tags
}

module "task_definition" {
  source             = "../../../modules/AWS/ECS/task_definition"
  execution_role_arn = ""
  file_system_id     = ""
  tags               = local.td_tags
  task_definition    = var.task_definition
  task_role_arn      = module.iam_role.iam_role_arn
}

module "ecs_cluster" {
  source                 = "../../../modules/AWS/ECS/cluster"
  capacity_provider_name = module.capacity_provider.capacity_provider_name
  cluster                = var.ecs_cluster
  tags                   = local.ecs_cluster_tags
}

module "ecs_service" {
  source                 = "../../../modules/AWS/ECS/service"
  capacity_provider_name = module.capacity_provider.capacity_provider_name
  elb_name               = ""
  iam_role_arn           = module.iam_role.iam_role_arn
  registry_arn           = ""
  security_group         = module.security_group.*.security_group_id
  service                = var.ecs_service
  subnet                 = module.subnet.*.subnet_id
  target_group_arn       = module.load_balancer_target_group
  task_definition_arn    = module.task_definition.task_definition_arn
  cluster_id             = module.ecs_cluster.cluster_id
}