output "id" {
  value = aws_codebuild_webhook.webhook.*.id
}

output "payload_url" {
  value = aws_codebuild_webhook.webhook.*.payload_url
}

output "secret" {
  value = aws_codebuild_webhook.webhook.*.secret
}

output "url" {
  value = aws_codebuild_webhook.webhook.*.url
}