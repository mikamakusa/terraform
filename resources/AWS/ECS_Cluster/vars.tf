variable "vpc" {
  type = "list"
}

variable "subnet" {
  type = "list"
}

variable "internet_gateway" {
  type = "list"
}

variable "route_table" {
  type = "list"
}

variable "route_table_association" {
  type = "list"
}

variable "security_group" {
  type = "list"
}

variable "security_group_rules" {
  type = "list"
}

variable "eip" {
  type = "list"
}

variable "nat_gateway" {
  type = "list"
}

variable "service_linked_role" {
  type = "list"
}

variable "iam_role" {
  type = "list"
}

variable "iam_role_policy" {
  type = "list"
}

variable "iam_instance_profile" {
  type = "list"
}

variable "iam_role_policy_attachment" {
  type = "list"
}

variable "key_pair" {
  type = "list"
}

variable "launch_configuration" {
  type = "list"
}

variable "autoscaling_group" {
  type = "list"
}

variable "load_balancer" {
  type = "list"
}

variable "load_balancer_target_group" {
  type = "list"
}

variable "load_balancer_listener" {
  type = "list"
}

variable "capacity_provider" {
  type = "list"
}

variable "task_definition" {
  type = "list"
}

variable "ecs_cluster" {
  type = "list"
}

variable "ecs_service" {
  type = "list"
}

variable "container_definitions" {
  type = "list"
}