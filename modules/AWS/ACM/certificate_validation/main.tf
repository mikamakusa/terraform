resource "aws_acm_certificate_validation" "certificate_validation" {
  count                   = length(var.certificate_validation)
  certificate_arn         = lookup(var.certificate_validation[count.index], "certificate_id") == "" ? var.certificate_arn : element(var.certificate_arn, lookup(var.certificate_validation[count.index], "certificate_id"))
  validation_record_fqdns = [lookup(var.certificate_validation[count.index], "validation_record_fqdns")]
}