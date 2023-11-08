variable "cluster" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "alb_create" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "alb" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "alb_cert" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "addons" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "api_key_reset" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "bind_service" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "cluster_feature" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "dedicated_host" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "dedicated_host_pool" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "ingress_instance" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "nlb_dns" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "storage_attachment" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "vpc_alb_create" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "vpc_alb" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "vpc_cluster" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "vpc_worker" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "vpc_worker_pool" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "worker_pool" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "worker_pool_zone_attachment" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "ob_logging" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}

variable "ob_monitoring" {
  type        = list(map(object({})))
  default     = []
  description = <<-EOT
  EOT
}
