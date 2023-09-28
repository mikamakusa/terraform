variable "region" {
  type        = string
  description = "Define the region in which the resources will be built"
}

variable "bucket" {
  type = map(object({
    bucket_prefix       = optional(string)
    force_destroy       = optional(bool)
    object_lock_enabled = optional(bool)
    accelerate          = optional(bool)
    versioning          = optional(bool)
    tiering_name        = optional(string)
    tiering = optional(object({
      access_tier = optional(string)
      days        = optional(number)
    }))
  }))
}

variable "logging" {
  type = list(object({
    target_bucket = string
    target_prefix = string
  }))
}

variable "encryption" {
  type = list(object({
    sse_algorithm     = optional(string)
    kms_master_key_id = optional(string)
  }))
}

variable "analytics" {
  type = list(object({
    name = string
  }))
}