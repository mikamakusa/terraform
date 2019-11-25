resource "tls_private_key" "private_key" {
  count       = length(var.private_key)
  algorithm   = lookup(var.private_key[count.index], "algorithm")
  rsa_bits    = lookup(var.private_key[count.index], "rsa_bits", null)
  ecdsa_curve = lookup(var.private_key[count.index], "ecdsa_curve", null)
}

resource "tls_self_signed_cert" "self_signed_cert" {
  count                 = length(var.private_key) == "0" ? "0" : length(var.self_signed)
  allowed_uses          = [lookup(var.self_signed[count.index], "allowed_uses")]
  key_algorithm         = lookup(var.self_signed[count.index], "key_algorithm")
  private_key_pem       = file("${path.cwd}/private_key/self_signed/${lookup(var.self_signed[count.index], "private_key_pam")}.pem")
  validity_period_hours = lookup(var.self_signed[count.index], "validity_period_hours")
  dns_names             = [lookup(var.self_signed[count.index], "dns_names", null)]
  ip_addresses          = [lookup(var.self_signed[count.index], "ip_addresses", null)]
  uris                  = [lookup(var.self_signed[count.index], "uris", null)]
  early_renewal_hours   = lookup(var.self_signed[count.index], "early_renewal_hours", null)
  is_ca_certificate     = lookup(var.self_signed[count.index], "is_ca_certificate", false)
  set_subject_key_id    = lookup(var.self_signed[count.index], "set_subject_key_id", false)
  subject               = lookup(var.self_signed[count.index], "subject")
}

resource "tls_cert_request" "cert_request" {
  count           = length(var.private_key) == "0" ? "0" : length(var.cert_request)
  key_algorithm   = lookup(var.cert_request[count.index], "key_algorithm")
  private_key_pem = file("${path.cwd}/private_key/${element(tls_self_signed_cert.self_signed_cert.*.private_key_pem, lookup(var.cert_request[count.index], "private_key_id"))}.pem")
  dns_names       = [lookup(var.cert_request[count.index], "dns_names", null)]
  ip_addresses    = [lookup(var.cert_request[count.index], "ip_addresses", null)]
  uris            = [lookup(var.cert_request[count.index], "uris", null)]
  subject         = lookup(var.cert_request[count.index], "subject")
}

resource "tls_locally_signed_cert" "locally_signed_cert" {
  count                 = length(var.private_key) == "0" ? "0" : length(var.locally_signed_cert)
  allowed_uses          = [lookup(var.locally_signed_cert[count.index], "allowed_uses")]
  ca_cert_pem           = lookup(var.locally_signed_cert[count.index], "ca_cert_pem")
  ca_key_algorithm      = lookup(var.locally_signed_cert[count.index], "ca_key_algorithm")
  ca_private_key_pem    = file("${path.cwd}/private_key/${element(tls_self_signed_cert.self_signed_cert.*.private_key_pem, lookup(var.locally_signed_cert[count.index], "private_key_id"))}.pem")
  cert_request_pem      = element(tls_self_signed_cert.self_signed_cert.*.cert_pem, lookup(var.locally_signed_cert[count.index], "cert_pem_id"))
  validity_period_hours = lookup(var.locally_signed_cert[count.index], "validity_period_hours")
  early_renewal_hours   = lookup(var.locally_signed_cert[count.index], "early_renewal_hours", null)
  is_ca_certificate     = lookup(var.locally_signed_cert[count.index], "is_ca_certificate", false)
  set_subject_key_id    = lookup(var.locally_signed_cert[count.index], "set_subject_key_id", false)
}

resource "aws_acm_certificate" "import_certificate" {
  count            = length(var.private_key) == "0" ? "0" : length(var.cert_import)
  private_key      = element(tls_private_key.private_key.*.private_key_pem, lookup(var.cert_import[count.index], "private_key_id"))
  certificate_body = element(tls_self_signed_cert.self_signed_cert.*.cert_pem, lookup(var.cert_import[count.index], "cert_pem_id"))
  tags             = lookup(var.cert_import[count.index], "tags")
}

resource "aws_acm_certificate_validation" "cert_validation" {
  count                   = length(var.cert_import) == "0" ? "0" : length(var.cert_validation)
  certificate_arn         = element(aws_acm_certificate.import_certificate.*.arn, lookup(var.cert_validation[count.index], "certificate_id"))
  validation_record_fqdns = [lookup(var.cert_validation[count.index], "validation_record_fqdns", null)]
}