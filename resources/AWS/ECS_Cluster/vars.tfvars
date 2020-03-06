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