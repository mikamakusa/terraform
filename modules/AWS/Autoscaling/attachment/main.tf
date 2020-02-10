resource "aws_autoscaling_attachment" "autoscaling_attachment" {
  count                  = length(var.autoscaling_attachment)
  autoscaling_group_name = lookup(var.autoscaling_attachment[count.index], "autoscaling_group_name")
  elb                    = element(var.elb_id, lookup(var.autoscaling_attachment[count.index], "elb_id"))
  alb_target_group_arn   = element(var.alb_target_group_arn, lookup(var.autoscaling_attachment[count.index], "alb_target_group_id"))
}