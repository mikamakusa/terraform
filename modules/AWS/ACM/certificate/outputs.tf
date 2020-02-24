output "certificate_authority_arn" {
  value = aws_acm_certificate.certificate.*.certificate_authority_arn
}

output "certificate_arn" {
  value = aws_acm_certificate.certificate.*.arn
}