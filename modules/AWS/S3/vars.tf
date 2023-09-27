variable "s3_bucket" {
  type = map(object({
    bucket_prefix        = optional(string)
    force_destroy        = optional(bool)
    object_lock_enabled  = optional(bool)
    s3_bucket_accelerate = optional(bool)
  }))
  description = "Define a S3 bucket resource"
}

variable "s3_bucket_analytics" {
  type = map(object({
    bucket = string
  }))
  description = "Define a bucket analythic configuration for a s3 bucket resource, a s3 analythic bucket is needed"
}

variable "s3_bucket_cors" {
  type = map(object({
    bucket = optional(string)
    cors_rule = optional(list(object({
      allowed_headers = optional(list(string))
      allowed_methods = optional(list(string))
      allowed_origins = optional(list(string))
      expose_headers  = optional(list(string))
      max_age_seconds = optional(number)
      id              = optional(string)
    })))
  }))
  description = "Enable Cross-Origin Resource Sharing for a s3 bucket"
}

variable "s3_bucket_tiering" {
  type = map(object({
    bucket        = optional(string)
    status        = optional(string)
    filter_prefix = optional(string)
    access_tier   = optional(string)
    days          = optional(number)
  }))
  description = "Define tiering configuration for s3 bucket"
}

variable "s3_bucket_inventory" {
  type        = any
  description = "Provides a S3 bucket inventory configuration resource"
}

variable "s3_bucket_lifecycle" {
  type        = any
  description = "Define the lifecycle of a S3 bucket, which consist of the Rule Metadata, a filter for identifying object on which the applies and transition or expiration actions"
}

variable "s3_bucket_logging" {
  type        = any
  description = "Define a bucket logging configuration for a s3 bucket resource, a s3 logging bucket is needed"
}

variable "s3_bucket_metric" {
  type        = any
  description = "Define a bucket logging configuration for a s3 bucket resource, a s3 logging bucket is needed"
}

variable "s3_bucket_notification" {
  type = any
}

variable "s3_bucket_object_lock" {
  type = any
}

variable "ownership_controls" {
  type = any
}

variable "bucket_policy" {
  type = any
}

variable "access_block" {
  type = any
}

variable "replication_configuration" {
  type = any
}