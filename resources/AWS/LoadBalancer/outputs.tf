output "lb_arn" {
  description = "LoadBalancer ARN"
  value = module.load_balancer.lb_arn
}

output "target_group_arn" {
  description = "Target Group ARN"
  value = module.load_balancer_target_group.target_group_arn
}