load_balancer = [
  {
    id                = "0"
    name              = "alb-ecs"
    internal          = "false"
    security_group_id = "0"
    subnet_id_1       = "0"
    subnet_id_2       = "1"
  }
]

load_balancer_target_group = [
  {
    id           = "0"
    name         = "tg-alb-ecs"
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

bucket = "tests-tfstate"
key    = "vpc.tfstate"
region = "eu-west-3"