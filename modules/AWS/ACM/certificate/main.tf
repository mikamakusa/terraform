resource "aws_acm_certificate" "certificate" {
  count                     = length(var.certificate)
  domain_name               = lookup(var.certificate[count.index], "domain_name")
  subject_alternative_names = [lookup(var.certificate[count.index], "subject_alternative_names")]
  validation_method         = lookup(var.certificate[count.index], "validation_method")
  certificate_authority_arn = lookup(var.certificate[count.index], "validation_method") == [] ? element(var.certificate_authority_arn, lookup(var.certificate[count.index], "certificate_authority_id")) : []
  private_key               = lookup(var.certificate[count.index], "validation_method") == [] ? element(var.private_key_pem, lookup(var.certificate[count.index], "private_key_id")) : []
  certificate_body          = lookup(var.certificate[count.index], "validation_method") == [] ? element(var.signed_cert_pem, lookup(var.certificate[count.index], "signe_cert_id")) : []

  dynamic "options" {
    for_each = lookup(var.certificate[count.index], "options")
    content {
      certificate_transparency_logging_preference = lookup(options.value, "certificate_transparency_logging_preference")
    }
  }
}