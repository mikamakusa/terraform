resource "aws_alb_listener_certificate" "listener_certificate" {
  count           = length(var.listener_certificate)
  certificate_arn = lookup(var.listener_certificate[count.index], "certificate_id") == [] ? var.certificate_arn : element(var.certificate_arn, lookup(var.listener_certificate[count.index], "certificate_id"))
  listener_arn    = lookup(var.listener_certificate[count.index], "listener_id") == [] ? var.listener_arn : element(var.listener_arn, lookup(var.listener_certificate[count.index], "listener_id"))
}