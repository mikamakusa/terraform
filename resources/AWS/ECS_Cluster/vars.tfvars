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
    availability_zone       = "eu-west-1b"
    map_public_ip_on_launch = "true"
  },
  {
    id                      = "1"
    vpc_id                  = "0"
    cidr_block              = "10.10.20.0/24"
    availability_zone       = "eu-west-1a"
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
    route = [
      {
        cidr_block     = "0.0.0.0/0"
        gateway_id     = "0"
        nat_gateway_id = ""
      }
    ]
  },
  {
    id     = "1"
    vpc_id = "0"
    route = [
      {
        cidr_block     = "0.0.0.0/0"
        gateway_id     = ""
        nat_gateway_id = "0"
      }
    ]
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
    protocol          = "TCP"
    from_port         = "22"
    to_port           = "22"
    security_group_id = "0"
    cidr_blocks       = "10.10.0.0/16"
  },
  {
    id                = "1"
    type              = "egress"
    protocol          = "TCP"
    from_port         = "80"
    to_port           = "80"
    security_group_id = "0"
    cidr_blocks       = "0.0.0.0/0"
  },
  {
    id                = "2"
    type              = "egress"
    protocol          = "-1"
    from_port         = "0"
    to_port           = "0"
    security_group_id = "0"
    cidr_blocks       = "0.0.0.0/0"
  },
  {
    id                = "3"
    type              = "egress"
    protocol          = "TCP"
    from_port         = "9000"
    to_port           = "10000"
    security_group_id = "0"
    cidr_blocks       = "0.0.0.0/0"
  },
]

eip = [
  {
    id     = "0"
    vpc_id = "0"
  }
]

service_linked_role = [
  {
    id               = "0"
    aws_service_name = "autoscaling"
    custom_suffix    = "jparnaudeau-demo"
  }
]

iam_role = [
  {
    id     = "0"
    name   = "ecs_service_role"
    policy = "ecs_service_policy"
    path   = "/"
  },
]

iam_role_policy = [
  {
    id      = "0"
    role_id = "0"
    name    = "ecs-ec2-role-policy"
  }
]

iam_instance_profile = [
  {
    id      = "0"
    role_id = "0"
    name    = "ecs_instance_profile"
  }
]

iam_role_policy_attachment = [
  {
    id          = "0"
    iam_role_id = "0"
    policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  },
  {
    id          = "1"
    iam_role_id = "0"
    policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  }
]

key_pair = [
  {
    id         = "0"
    key_name   = "ecs_key_pair"
    public_key = "ecs_demo"
  }
]

launch_configuration = [
  {
    id                          = "0"
    image_id                    = "ami-0851c53aff84212c3"
    instance_type               = "t2.small"
    security_group_id           = "0"
    iam_instance_profile_id     = "0"
    associate_public_ip_address = "true"
    key_pair_id                 = "0"
    root_block_device = [
      {
        volume_type = "standard"
        volume_size = "100"
      }
    ]
    lifecycle = [
      {
        create_before_destroy = "true"
      }
    ]
  }
]

autoscaling_group = [
  /*{
    id                       = "0"
    name                     = "ecs-autoscaling-group"
    max_size                 = "5"
    min_size                 = "1"
    desired_capacity         = "1"
    service_linked_role_id   = "0"
    launch_configuration_id  = "0"
    health_check_type        = "ELB"
    vpc_zone_identifier_id_1 = "0"
    vpc_zone_identifier_id_2 = "1"
    target_group_id          = "0"
    initial_lifecycle_hook   = []
    mixed_instances_policy   = []
  }*/
]

load_balancer = [
  {
    id                = "0"
    name              = "alb-ecs"
    internal          = "true"
    security_group_id = "0"
    subnet_id_1       = "0"
    subnet_id_2       = "1"
  }
]

load_balancer_target_group = [
  {
    id           = "0"
    name         = "tg-alb-ecs"
    port         = "9090"
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
    port             = "9090"
    protocol         = "HTTP"
    default_action = [
      {
        target_group_id = "0"
        type            = "forward"
      }
    ]
  }
]

capacity_provider = [
  /*    {
    id   = "0"
    name = "ecs-demo"
    auto_scaling_group_provider = [
      {
        autoscaling_group_id      = "0"
        maximum_scaling_step_size = "5"
        minimum_scaling_step_size = "1"
        target_capacity           = "1"
      }
    ]
  }*/
]
task_definition = [
  {
    id                       = "0"
    family                   = "app"
    network_mode             = "awsvpc"
    container_definition_id  = "0"
    task_role_id             = "0"
    execution_role_id        = "0"
    requires_compatibilities = "FARGATE"
    container_definition     = "ecs-fargate-demo"
    volume                   = []
    placement_constraints    = []
    proxy_configuration      = []
  }
]

ecs_cluster = [
  {
    id                                 = "0"
    name                               = "ecs-cluster"
    capacity_provider_id               = "-1"
    setting                            = []
    default_capacity_provider_strategy = []
  }
]

ecs_service = [
  {
    id                         = "0"
    name                       = "ecs-fargate-demo-service"
    cluster_id                 = "0"
    desired_count              = "1"
    launch_type                = "FARGATE"
    task_definition_id         = "0"
    iam_role_id                = "0"
    capacity_provider_strategy = []
    ordered_placement_strategy = []
    load_balancer = [
      {
        elb_id          = "0"
        target_group_id = "0"
        container_name  = "prometheus"
        container_port  = "9090"
      }
    ]
    placement_constraints = []
    network_configuration = [
      {
        security_group_id = "0"
        subnet_id_1       = "0"
        subnet_id_2       = "1"
      }
    ]
    service_registries    = []
    deployment_controller = []
  }
]

container_definitions = [
  {
    id                   = "0"
    cpu                  = "256"
    memory               = "512"
    name                 = "prometheus"
    image                = "prom/prometheus"
    containerPort        = "9090"
    hostPort             = "9090"
    network_mode         = "awsvpc"
    container_definition = "ecs-fargate-demo"
  }
]

bucket = "tests-tfstate"
region = "eu-west-3"