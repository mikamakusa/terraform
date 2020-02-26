vpc = [
  {
    id                   = "0"
    cidr_block           = "10.10.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = "true"
    enable_dns_support   = "true"
  }
]

subnet = [
  {
    id                      = "0"
    vpc_id                  = "0"
    cidr_block              = "10.10.10.0/24"
    availability_zone       = ""
    map_public_ip_on_launch = "true"
  },
  {
    id                      = "1"
    vpc_id                  = "0"
    cidr_block              = "10.10.20.0/24"
    availability_zone       = ""
    map_public_ip_on_launch = "true"
  }
]

internet_gateway = [
  {
    id     = "0"
    vpc_id = "0"
  }
]

route_table = [
  {
    id     = "0"
    vpc_id = "0"
    route = [{
      cidr_block     = "0.0.0.0/0"
      gateway_id     = "0"
      nat_gateway_id = ""
    }]
  },
  {
    id     = "1"
    vpc_id = "0"
    route = [{
      cidr_block     = "0.0.0.0/0"
      gateway_id     = ""
      nat_gateway_id = "0"
    }]
  }
]

nat_gateway = [
  {
    id            = "0"
    allocation_id = "0"
    subnet_id     = "0"
  }
]

route_table_association = [
  {
    id             = "0"
    route_table_id = "0"
    subnet_id      = "0"
  },
  {
    id             = "1"
    route_table_id = "1"
    subnet_id      = "1"
  }
]

security_group = [
  {
    id          = "0"
    name        = "ECS_security_group"
    description = "ECS_security_group"
    vpc_id      = "0"
  }
]

security_group_rules = [
  {
    id                = "0"
    type              = "ingress"
    protocal          = "TCP"
    from_port         = "22"
    to_port           = "22"
    security_group_id = "0"
  },
  {
    id                = "1"
    type              = "egress"
    protocal          = "TCP"
    from_port         = "80"
    to_port           = "80"
    security_group_id = "0"
  },
  {
    id                = "2"
    type              = "egress"
    protocal          = "-1"
    from_port         = "0"
    to_port           = "0"
    security_group_id = "0"
  }
]

eip = [
  {
    id     = "0"
    vpc_id = "0"
  }
]

service_linked_role = []
iam_role = [
  {
    id     = "0"
    name   = "ecs_service_role"
    policy = "ecs_service_policy"
    path   = "/"
  },
  {
    id     = "1"
    name   = "ecs_instance_role"
    policy = "ecs_instance_policy"
    path   = "/"
  }
]

iam_role_policy = [
  {
    id      = "0"
    role_id = "1"
    name    = "ecs-ec2-role-policy"
  }
]

iam_instance_profile = [
  {
    id      = "0"
    role_id = "1"
    name    = "ecs_instance_profile"
  }
]

launch_configuration = []
autoscaling_group    = []
load_balancer = [
  {
    id       = "0"
    name     = "alb_ecs"
    internal = "true"
  }
]

load_balancer_target_group = [
  {
    id           = "0"
    name         = "tg_alb_ecs"
    port         = "80"
    protocol     = "HTTP"
    vpc_id       = "0"
    target_type  = "ip"
    health_check = []
  }
]

load_balancer_listener = [
  {
    id               = "0"
    load_balancer_id = "0"
    port             = "80"
    protocol         = "HTTP"
    default_action = [
      {
        target_group_id = "0"
        type            = "forward"
      }
    ]
  }
]

capacity_provider = []
task_definition = [
  {
    id                    = "0"
    family                = "app"
    network_mode          = "aws_vpc"
    cpu                   = ""
    memory                = ""
    container_definition  = "ecs_fargate_demo"
    volume                = []
    placement_constraints = []
    proxy_configuration   = []
  }
]

ecs_cluster = [
  {
    id                                 = "0"
    name                               = "ecs_cluster"
    setting                            = []
    default_capacity_provider_strategy = []
  }
]

ecs_service = [
  {
    id                         = "0"
    name                       = "ecs_fargate_demo_service"
    cluster_id                 = "0"
    desired_count              = "1"
    launch_type                = "FARGATE"
    capacity_provider_strategy = []
    ordered_placement_strategy = []
    load_balancer = [
      {
        elb_id          = "0"
        target_group_id = "0"
        container_name  = "ecs_fargate_demo_container"
        container_port  = "80"
      }
    ]
    placement_constraints = []
    network_configuration = []
    service_registries    = []
    deployment_controller = []
  }
]
