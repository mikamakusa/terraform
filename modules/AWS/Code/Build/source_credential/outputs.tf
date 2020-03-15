output "id" {
  value = aws_codebuild_source_credential.source_credential.*.id
}

output "arn" {
  value = aws_codebuild_source_credential.source_credential.*.arn
}