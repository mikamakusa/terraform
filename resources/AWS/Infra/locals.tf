locals {
  vpc_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "VPC"
  }
  subnet_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "subnet"
  }
  ig_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "Internet_Gateway"
  }
  rt_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "route_table"
  }
  sg_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "security_group"
  }
  lb_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "ALB"
  }
  lb_target_group_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "ALB_target_group"
  }
  cp_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "capacity_provider"
  }
  td_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "task_definition"
  }
  ecs_cluster_tags = {
    "test:environment" = "test-perso"
    "test:customer"    = "test"
    "test:owner"       = "perso"
    "test:resource"    = "ecs_cluster"
  }
}
