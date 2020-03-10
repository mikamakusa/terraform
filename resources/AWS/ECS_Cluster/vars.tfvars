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
    container_definitions_id = "0"
    task_role_id             = "0"
    execution_role_id        = "0"
    requires_compatibilities = "FARGATE"
    container_definition     = "ecs-fargate-demo"
    container_definitions    = "prometheus"
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

bucket = "tests-tfstate"
region = "eu-west-3"


## Test

container_definitions = [
  {
    id                     = "0"
    name                   = "prometheus"
    hostname               = ""
    interactive            = ""
    image                  = "prom/prometheus"
    memory                 = 256
    memoryReservation      = 256
    cpu                    = 256
    essential              = true
    readonlyRootFilesystem = ""
    environment            = ""
    portMappings = [
      {
        containerPort = 9090
        hostPort      = 9090
        protocol      = "tcp"
      }
    ]
    logConfiguration = {
      logDriver : "awslogs",
      options = {
        "awslogs-region" : "eu-west-3",
        "awslogs-group" : "ecs-fargate",
        "awslogs-stream-prefix" : "prometheus"
      }
    }
    command               = ["--config.file=/etc/prometheus/prometheus.yml", "--web.enable-lifecycle"]
    container_depends_on  = ""
    disableNetworking     = false
    dnsSearchDomains      = ""
    dnsServers            = ""
    dockerLabels          = ""
    dockerSecurityOptions = ""
    entryPoint            = ""
    healthCheck           = ""
    links                 = ""
    linuxParameters       = ""
    mountPoints           = ""
    repositoryCredentials = ""
    secrets               = ""
    start_timeout         = ""
    stop_timeout          = ""
    systemControls        = ""
    ulimits               = ""
    user                  = ""
    volumesFrom           = ""
    workingDirectory      = ""
    extraHosts            = ""
    pseudoTerminal        = ""
    dependsOn             = ""
  }
]
