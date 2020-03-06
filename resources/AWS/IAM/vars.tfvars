service_linked_role = [
  {
    id               = "0"
    aws_service_name = "autoscaling"
    custom_suffix    = "demo"
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