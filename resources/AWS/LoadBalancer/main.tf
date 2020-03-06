module "load_balancer" {
  source            = "../../../modules/AWS/ALB/lb"
  alb               = var.load_balancer
  security_group_id = data.terraform_remote_state.vpc.outputs.security_group_id
  subnet_id         = [
    data.terraform_remote_state.vpc.outputs.subnet_id[0],
    data.terraform_remote_state.vpc.outputs.subnet_id[1]
  ]
  tags              = local.lb_tags
}

module "load_balancer_target_group" {
  source       = "../../../modules/AWS/ALB/target_group"
  tags         = local.lb_target_group_tags
  target_group = var.load_balancer_target_group
  vpc_id       = data.terraform_remote_state.vpc.outputs.vpc_id
}

module "load_balancer_listener" {
  source            = "../../../modules/AWS/ALB/listener"
  listener          = var.load_balancer_listener
  load_balancer_arn = module.load_balancer.lb_arn
  target_group_arn  = module.load_balancer_target_group.target_group_arn
}