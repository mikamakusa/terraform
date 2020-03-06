# Specific Security Group / Rule
resource "aws_security_group" "prometheus_sg" {
  name        = "sgr-prometheus-service"
  description = "Allow inbound traffic to Prometheus Service"
  vpc_id      = join("", data.terraform_remote_state.vpc.outputs.vpc_id)

  tags = merge(
  {
    "Name" = "sgr-prometheus-service"
  },
  local.td_tags,
  )
}

resource "aws_security_group_rule" "ip_alb_ingress_https" {
  type                     = "ingress"
  from_port                = "9090"
  to_port                  = "9090"
  protocol                 = "tcp"
  description              = "Allow ALB to reach Prometheus ervice"
  source_security_group_id = join("", data.terraform_remote_state.vpc.outputs.security_group_id)
  security_group_id        = aws_security_group.prometheus_sg.id
}

resource "aws_security_group_rule" "grade_www_egress_all" {
  type        = "egress"
  from_port   = "0"
  to_port     = "0"
  protocol    = "-1"
  description = "Allow all Outbound Traffic for ECS"

  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.prometheus_sg.id
}

# ECS
module "task_definition" {
  source                = "../../../modules/AWS/ECS/task_definition"
  execution_role_arn    = data.terraform_remote_state.iam.outputs.iam_role_arn[0]
  file_system_id        = ""
  tags                  = local.td_tags
  task_definition       = var.task_definition
  task_role_arn         = data.terraform_remote_state.iam.outputs.iam_role_arn[0]
  container_definitions = data.template_file.container_definitions.*.rendered
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
  security_group         = aws_security_group.prometheus_sg.id
  service                = var.ecs_service
  subnet                 = [
    data.terraform_remote_state.vpc.outputs.subnet_id[2],
    data.terraform_remote_state.vpc.outputs.subnet_id[3]
  ]
  target_group_arn       = data.terraform_remote_state.lb.outputs.target_group_arn
  task_definition_arn    = module.task_definition.task_definition_arn
  cluster_id             = module.ecs_cluster.cluster_id
}