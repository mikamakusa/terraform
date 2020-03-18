output "id" {
  value = aws_codepipeline.pipeline.*.id
}

output "arn" {
  value = aws_codepipeline.pipeline.*.arn
}