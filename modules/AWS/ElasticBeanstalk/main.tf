resource "aws_s3_bucket" "s3_bucket" {
  bucket = ""
}

resource "aws_s3_bucket_object" "s3_bucket_object" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = ""
}

resource "aws_iam_role" "role" {
  name = ""
  assume_role_policy = ""
}

module "Application" {
  source       = "Application"
  application  = var.application
  service_role = aws_iam_role.role.id
}

module "Application_Version" {
  source              = "Application_Version"
  application         = module.Application.name
  application_version = var.application_version
  bucket              = aws_s3_bucket.s3_bucket.id
  object              = aws_s3_bucket_object.s3_bucket_object.id
}

module "Configuration_template" {
  source                 = "Configuration_Template"
  application            = module.Application.name
  configuration_template = var.configuration_template
}

module "Environment" {
  source      = "Environment"
  application = module.Application.name
  environment = var.environment
}
