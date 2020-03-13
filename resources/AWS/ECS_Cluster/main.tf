# Specific Security Group / Rule
module "security_group" {
  source         = "../../../modules/AWS/VPC/security_groups"
  security_group = var.security_group
  tags           = local.td_tags
  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
}

module "security_group_rules" {
  source                   = "../../../modules/AWS/VPC/security_group_rule"
  security_group_id        = module.security_group.security_group_id
  security_group_rule      = var.security_group_rules
  source_security_group_id = data.terraform_remote_state.vpc.outputs.security_group_id
}

# ECS
module "task_definition" {
  source                = "../../../modules/AWS/ECS/task_definition"
  execution_role_arn    = data.terraform_remote_state.iam.outputs.iam_role_arn[0]
  file_system_id        = ""
  tags                  = local.td_tags
  task_definition       = var.task_definition
  task_role_arn         = data.terraform_remote_state.iam.outputs.iam_role_arn[0]
  container_definitions = var.container_definitions
}

module "ecs_cluster" {
  source                 = "../../../modules/AWS/ECS/cluster"
  capacity_provider_name = ""
  cluster                = var.ecs_cluster
  tags                   = local.ecs_cluster_tags
}

module "ecs_service" {
  source                 = "../../../modules/AWS/ECS/service"
  capacity_provider_name = ""
  elb_name               = data.terraform_remote_state.lb.outputs.lb_arn
  iam_role_arn           = data.terraform_remote_state.iam.outputs.iam_role_arn[0]
  registry_arn           = ""
  security_group         = module.security_group.security_group_id
  service                = var.ecs_service
  subnet = [
    data.terraform_remote_state.vpc.outputs.subnet_id[2],
    data.terraform_remote_state.vpc.outputs.subnet_id[3]
  ]
  target_group_arn    = data.terraform_remote_state.lb.outputs.target_group_arn
  task_definition_arn = module.task_definition.task_definition_arn
  cluster_id          = module.ecs_cluster.cluster_id
}