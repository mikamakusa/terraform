data "aws_iam_policy_document" "assumerole_cloufront" {
  statement {
    effect = "Allow"

    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_kinesis_stream" "this" {
  count = var.kinesis_stream ? 1 : 0
  name  = var.kinesis_stream
}

data "aws_iam_policy_document" "kinesis_stream" {
  count = var.kinesis_stream ? 1 : 0
  statement {
    effect = "Allow"

    actions = [
      "kinesis:DescribeStreamSummary",
      "kinesis:DescribeStream",
      "kinesis:PutRecord",
      "kinesis:PutRecords",
    ]

    resources = [data.aws_kinesis_stream.this.arn]
  }
}

data "aws_wafv2_web_acl" "this" {
  count = var.web_acl ? 1 : 0
  name  = var.web_acl
  scope = "CLOUDFRONT"
}

data "aws_lambda_function" "this" {
  count         = var.lambda_function ? 1 : 0
  function_name = var.lambda_function
}

data "aws_acm_certificate" "this" {
  count  = var.acm_certificate ? 1 : 0
  domain = var.acm_certificate
}